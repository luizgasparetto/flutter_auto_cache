import 'dart:convert';

import '../../../../core/services/cryptography/i_cryptography_service.dart';
import '../../../../core/services/storages/prefs/i_prefs_service.dart';
import '../../domain/entities/cache_entity.dart';
import '../../infra/datasources/i_query_data_cache_datasource.dart';
import '../adapters/cache_adapter.dart';

/// A concrete implementation of the [IQueryDataCacheDatasource] interface for caching query data.
///
/// This class utilizes a preferences service and a cryptography service to securely retrieve cached query data.
final class QueryDataCacheDatasource implements IQueryDataCacheDatasource {
  /// The service responsible for managing persistent storage of key-value pairs.
  final IPrefsService _prefsService;

  /// The service providing encryption and decryption utilities for secure data handling.
  final ICryptographyService _cryptographyService;

  /// Constructs a [QueryDataCacheDatasource] instance.
  ///
  /// The [prefsService] parameter is required for persistent data storage,
  /// while the [cryptographyService] parameter ensures that all cached data is securely encrypted and decrypted.
  const QueryDataCacheDatasource(this._prefsService, this._cryptographyService);

  /// Retrieves a cached entity of type [T] using the provided [key].
  ///
  /// This method fetches the value from preferences via the [_prefsService],
  /// decrypts it using the [_cryptographyService], and decodes the JSON representation
  /// to return a [CacheEntity].
  ///
  /// - Parameter [key]: The key used to identify the cached entity.
  ///
  /// Returns:
  /// - A [CacheEntity] object of type [T] if found, otherwise `null`.
  @override
  CacheEntity<T>? get<T extends Object>(String key) {
    final decodedResponse = _getDecodedResponse(key);

    if (decodedResponse == null) return null;

    return CacheAdapter.fromJson<T>(decodedResponse);
  }

  @override
  CacheEntity<T>? getList<T extends Object, DataType extends Object>(String key) {
    final decodedResponse = _getDecodedResponse(key);

    if (decodedResponse == null) return null;

    return CacheAdapter.listFromJson<T, DataType>(decodedResponse);
  }

  /// Retrieves all keys currently stored in the preferences.
  ///
  /// This method interacts with the [_prefsService] to obtain the list of keys
  /// used for storing cached entities.
  ///
  /// Returns:
  /// - A list of strings representing the keys.
  @override
  List<String> getKeys() {
    return _prefsService.getKeys();
  }

  Map<String, dynamic>? _getDecodedResponse(String key) {
    final response = _prefsService.get(key: key);

    if (response == null) return null;

    final decrypted = _cryptographyService.decrypt(response);

    return jsonDecode(decrypted);
  }
}
