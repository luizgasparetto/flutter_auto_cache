import 'dart:convert';

import '../../../../core/shared/services/cryptography_service/i_cryptography_service.dart';
import '../../../../core/shared/services/kvs_service/i_kvs_service.dart';

import '../../domain/entities/data_cache_entity.dart';

import '../../infra/datasources/i_command_data_cache_datasource.dart';
import '../adapters/data_cache_adapter.dart';

final class CommandDataCacheDatasource implements ICommandDataCacheDatasource {
  final IKvsService kvsService;
  final ICryptographyService cryptographyService;

  const CommandDataCacheDatasource(this.kvsService, this.cryptographyService);

  @override
  Future<void> write<T extends Object>(DataCacheEntity<T> cache) async {
    final encryptedData = getEncryptedData<T>(cache);

    await kvsService.save(key: cache.id, data: encryptedData);
  }

  @override
  Future<void> clear() => kvsService.clear();

  @override
  Future<void> delete(String key) => kvsService.delete(key: key);

  String getEncryptedData<T extends Object>(DataCacheEntity<T> dataCache) {
    final data = DataCacheAdapter.toJson<T>(dataCache);

    final encodedData = jsonEncode(data);
    return cryptographyService.encrypt(encodedData);
  }
}
