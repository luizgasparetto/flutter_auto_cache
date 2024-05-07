import 'dart:convert';

import '../../../../core/services/cryptography/i_cryptography_service.dart';
import '../../../../core/services/storages/prefs/i_prefs_service.dart';
import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/entities/cache_entity.dart';
import '../../infra/datasources/i_command_data_cache_datasource.dart';
import '../adapters/cache_adapter.dart';

/// A concrete implementation of the [ICommandDataCacheDatasource] interface for caching command data.
///
/// This class uses a preferences service and a cryptography service to store, encrypt, and clear cached data securely.
final class CommandDataCacheDatasource implements ICommandDataCacheDatasource {
  /// The service responsible for managing persistent storage of key-value pairs.
  final IPrefsService _prefsService;

  /// The service providing encryption and decryption utilities for secure data handling.
  final ICryptographyService _cryptographyService;

  /// Constructs a [CommandDataCacheDatasource] instance.
  ///
  /// The [prefsService] parameter is required to handle persistent data storage,
  /// while the [cryptographyService] parameter ensures that all cached data is securely encrypted.
  const CommandDataCacheDatasource(
    this._prefsService,
    this._cryptographyService,
  );

  /// Persists a data object in the cache, ensuring its security via encryption.
  ///
  /// The [dto] parameter provides the necessary data and metadata required for caching.
  /// The data is first serialized to JSON, encrypted, and then saved using the preferences service.
  ///
  /// - Parameter [dto]: A [SaveCacheDTO] containing the data and metadata to be cached.
  @override
  Future<void> save<T extends Object>(SaveCacheDTO<T> dto) async {
    final cache = CacheEntity.toSave(dto);
    final data = CacheAdapter.toJson(cache);

    final encodedData = jsonEncode(data);
    final encrypted = _cryptographyService.encrypt(encodedData);

    await _prefsService.save(key: dto.key, data: encrypted);
  }

  /// Deletes a cached data entry based on the provided [key].
  ///
  /// The data corresponding to the [key] is removed from the persistent storage.
  ///
  /// - Parameter [key]: A unique identifier representing the cached data entry to delete.
  @override
  Future<void> delete(String key) async {
    return _prefsService.delete(key: key);
  }

  /// Clears all cached data.
  ///
  /// This operation removes all key-value pairs stored in the persistent storage.
  @override
  Future<void> clear() async {
    return _prefsService.clear();
  }
}
