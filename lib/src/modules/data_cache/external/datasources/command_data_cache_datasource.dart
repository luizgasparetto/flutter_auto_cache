import 'dart:convert';

import '../../../../core/services/cryptography_service/i_cryptography_service.dart';
import '../../../../core/services/kvs_service/i_kvs_service.dart';

import '../../domain/dtos/update_cache_dto.dart';
import '../../domain/dtos/write_cache_dto.dart';
import '../../domain/entities/data_cache_entity.dart';

import '../../infra/datasources/i_command_data_cache_datasource.dart';
import '../adapters/data_cache_adapter.dart';
import '../adapters/dtos/update_cache_dto_adapter.dart';
import '../adapters/dtos/write_cache_dto_adapter.dart';

final class CommandDataCacheDatasource implements ICommandDataCacheDatasource {
  final IKvsService kvsService;
  final ICryptographyService cryptographyService;

  const CommandDataCacheDatasource(this.kvsService, this.cryptographyService);

  @override
  Future<void> save<T extends Object>(WriteCacheDTO<T> dto) async {
    final dataCache = WriteCacheDtoAdapter.toEntity<T>(dto);
    final encryptedData = getEncryptedData<T>(dataCache);

    await kvsService.save(key: dto.key, data: encryptedData);
  }

  @override
  Future<void> update<T extends Object>(UpdateCacheDTO<T> dto) async {
    final dataCache = UpdateCacheDtoAdapter.toEntity<T>(dto);
    final encryptedData = getEncryptedData<T>(dataCache);

    await kvsService.save(key: dto.previewCache.id, data: encryptedData);
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
