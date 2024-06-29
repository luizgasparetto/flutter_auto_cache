import 'dart:convert';

import '../../../../../core/services/cryptography_service/i_cryptography_service.dart';
import '../../../../../core/services/kvs_service/i_kvs_service.dart';
import '../../../domain/entities/data_cache_entity.dart';
import '../../../infra/datasources/data_cache/i_query_data_cache_datasource.dart';
import '../../adapters/data_cache_adapter.dart';

/// A concrete implementation of the [IQueryDataCacheDatasource] interface for caching query data.
///
/// This class utilizes a preferences service and a cryptography service to securely retrieve cached query data.
final class QueryDataCacheDatasource implements IQueryDataCacheDatasource {
  final IKvsService _kvsService;

  /// The service responsible for managing persistent storage of key-value pairs.

  /// The service providing encryption and decryption utilities for secure data handling.
  final ICryptographyService _cryptographyService;

  /// Constructs a [QueryDataCacheDatasource] instance.
  ///
  /// The [prefsService] parameter is required for persistent data storage,
  /// while the [cryptographyService] parameter ensures that all cached data is securely encrypted and decrypted.
  const QueryDataCacheDatasource(this._kvsService, this._cryptographyService);

  @override
  DataCacheEntity<T>? get<T extends Object>(String key) {
    final decodedResponse = _getDecodedResponse(key);

    if (decodedResponse == null) return null;

    return DataCacheAdapter.fromJson<T>(decodedResponse);
  }

  @override
  DataCacheEntity<T>? getList<T extends Object, DataType extends Object>(String key) {
    final decodedResponse = _getDecodedResponse(key);

    if (decodedResponse == null) return null;

    return DataCacheAdapter.listFromJson<T, DataType>(decodedResponse);
  }

  @override
  List<String> getKeys() {
    return _kvsService.getKeys();
  }

  Map<String, dynamic>? _getDecodedResponse(String key) {
    final response = _kvsService.get(key: key);

    if (response == null) return null;

    final decrypted = _cryptographyService.decrypt(response);

    return jsonDecode(decrypted);
  }
}