import 'dart:convert';

import 'package:flutter_auto_cache/src/modules/data_cache/domain/entities/data_cache_entity.dart';

import '../../../../../core/services/cryptography_service/i_cryptography_service.dart';
import '../../../../../core/services/kvs_service/i_kvs_service.dart';

import '../../../domain/dtos/update_cache_dto.dart';
import '../../../domain/dtos/write_cache_dto.dart';

import '../../../infra/datasources/data_cache/i_command_data_cache_datasource.dart';

import '../../adapters/data_cache_adapter.dart';
import '../../adapters/dtos/write_cache_dto_adapter.dart';

/// A concrete implementation of the [ICommandDataCacheDatasource] interface for caching command data.
///
/// This class uses a preferences service and a cryptography service to store, encrypt, and clear cached data securely.
final class CommandDataCacheDatasource implements ICommandDataCacheDatasource {
  /// The service responsible for managing persistent storage of key-value pairs.
  final IKvsService _kvsService;

  /// The service providing encryption and decryption utilities for secure data handling.
  final ICryptographyService _cryptographyService;

  /// Constructs a [CommandDataCacheDatasource] instance.
  ///
  /// The [prefsService] parameter is required to handle persistent data storage,
  /// while the [cryptographyService] parameter ensures that all cached data is securely encrypted.
  const CommandDataCacheDatasource(this._kvsService, this._cryptographyService);

  @override
  Future<void> save<T extends Object>(WriteCacheDTO<T> dto) async {
    final dataCache = WriteCacheDTOAdapter.toSave(dto);
    final encryptedJson = _getEncryptedJson(dataCache);

    await _kvsService.save(key: dto.key, data: encryptedJson);
  }

  @override
  Future<void> update<T extends Object>(UpdateCacheDTO<T> dto) async {
    final dataCache = WriteCacheDTOAdapter.toUpdate(dto);
    final encryptedJson = _getEncryptedJson(dataCache);

    await _kvsService.save(key: dto.previewCache.id, data: encryptedJson);
  }

  @override
  Future<void> delete(String key) async {
    return _kvsService.delete(key: key);
  }

  @override
  Future<void> clear() async {
    return _kvsService.clear();
  }

  String _getEncryptedJson<T extends Object>(DataCacheEntity<T> dataCache) {
    final data = DataCacheAdapter.toJson(dataCache);

    final encodedData = jsonEncode(data);
    return _cryptographyService.encrypt(encodedData);
  }
}
