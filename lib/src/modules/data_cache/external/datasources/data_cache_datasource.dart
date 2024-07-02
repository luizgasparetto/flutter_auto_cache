import 'dart:convert';

import '../../../../core/services/cache_size_service/cache_size_service.dart';
import '../../../../core/services/cryptography_service/i_cryptography_service.dart';
import '../../../../core/services/kvs_service/i_kvs_service.dart';
import '../../../../core/extensions/nullable_extensions.dart';

import '../../domain/dtos/update_cache_dto.dart';
import '../../domain/dtos/write_cache_dto.dart';
import '../../domain/entities/data_cache_entity.dart';

import '../../infra/datasources/i_data_cache_datasource.dart';

import '../adapters/data_cache_adapter.dart';
import '../adapters/dtos/update_cache_dto_adapter.dart';
import '../adapters/dtos/write_cache_dto_adapter.dart';

final class DataCacheDatasource implements IDataCacheDatasource {
  final IKvsService _kvsService;
  final ICryptographyService _cryptographyService;
  final ICacheSizeService _sizeService;

  const DataCacheDatasource(this._kvsService, this._cryptographyService, this._sizeService);

  @override
  DataCacheEntity<T>? get<T extends Object>(String key) {
    final response = _getDecryptedJson(key);

    return response.let(DataCacheAdapter.fromJson<T>);
  }

  @override
  DataCacheEntity<T>? getList<T extends Object, DataType extends Object>(String key) {
    final response = _getDecryptedJson(key);

    return response.let(DataCacheAdapter.listFromJson<T, DataType>);
  }

  @override
  Future<bool> accomodateCache<T extends Object>(DataCacheEntity<T> dataCache) async {
    final data = _getEncryptedData<T>(dataCache);

    return _sizeService.canAccomodateCache(data);
  }

  @override
  Future<void> save<T extends Object>(WriteCacheDTO<T> dto) async {
    final dataCache = WriteCacheDtoAdapter.toEntity<T>(dto);
    final encryptedData = _getEncryptedData<T>(dataCache);

    await _kvsService.save(key: dto.key, data: encryptedData);
  }

  @override
  Future<void> update<T extends Object>(UpdateCacheDTO<T> dto) async {
    final dataCache = UpdateCacheDtoAdapter.toEntity<T>(dto);
    final encryptedData = _getEncryptedData<T>(dataCache);

    await _kvsService.save(key: dto.previewCache.id, data: encryptedData);
  }

  @override
  List<String> getKeys() => _kvsService.getKeys();

  @override
  Future<void> delete(String key) => _kvsService.delete(key: key);

  @override
  Future<void> clear() async => _kvsService.clear();

  String _getEncryptedData<T extends Object>(DataCacheEntity<T> dataCache) {
    final data = DataCacheAdapter.toJson(dataCache);

    final encodedData = jsonEncode(data);
    return _cryptographyService.encrypt(encodedData);
  }

  Map<String, dynamic>? _getDecryptedJson(String key) {
    final response = _kvsService.get(key: key);

    if (response == null) return null;

    final decrypted = _cryptographyService.decrypt(response);
    return jsonDecode(decrypted);
  }
}
