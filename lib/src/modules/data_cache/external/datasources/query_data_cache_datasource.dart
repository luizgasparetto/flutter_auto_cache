import 'dart:convert';
import 'dart:typed_data';

import '../../../../core/shared/extensions/nullable_extensions.dart';

import '../../../../core/shared/services/cache_size_service/cache_size_service.dart';
import '../../../../core/shared/services/cryptography_service/i_cryptography_service.dart';
import '../../../../core/shared/services/kvs_service/i_kvs_service.dart';

import '../../domain/entities/data_cache_entity.dart';
import '../../infra/datasources/i_query_data_cache_datasource.dart';
import '../adapters/data_cache_adapter.dart';

final class QueryDataCacheDatasource implements IQueryDataCacheDatasource {
  final IKvsService kvsService;
  final ICryptographyService cryptographyService;
  final ICacheSizeService sizeService;

  const QueryDataCacheDatasource(this.kvsService, this.cryptographyService, this.sizeService);

  @override
  DataCacheEntity<T>? get<T extends Object>(String key) {
    final response = getDecryptedJson(key);

    return response.let(DataCacheAdapter.fromJson<T>);
  }

  @override
  DataCacheEntity<T>? getList<T extends Object, DataType extends Object>(String key) {
    final response = getDecryptedJson(key);

    return response.let(DataCacheAdapter.listFromJson<T, DataType>);
  }

  @override
  Future<bool> accomodateCache<T extends Object>(DataCacheEntity<T> dataCache) async {
    final data = DataCacheAdapter.toJson<T>(dataCache);
    final encodedData = jsonEncode(data);

    final encryptedData = cryptographyService.encrypt(encodedData);
    final bytes = Uint8List.fromList(utf8.encode(encryptedData));

    return sizeService.canAccomodateCache(bytes);
  }

  @override
  List<DataCacheEntity<Object>?> getAll() {
    final keys = kvsService.getKeys();

    return keys.map((key) => get(key)).toList();
  }

  @override
  List<String> getKeys() => kvsService.getKeys();

  Map<String, dynamic>? getDecryptedJson(String key) {
    final response = kvsService.get(key: key);

    if (response == null) return null;

    final decrypted = cryptographyService.decrypt(response);
    return jsonDecode(decrypted);
  }
}
