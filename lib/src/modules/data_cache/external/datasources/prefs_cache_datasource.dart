import 'dart:convert';

import '../../../../core/services/storages/prefs/i_prefs_service.dart';
import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/entities/cache_entity.dart';
import '../../infra/datasources/i_prefs_cache_datasource.dart';
import '../adapters/cache_adapter.dart';

final class PrefsCacheDatasource implements IPrefsCacheDatasource {
  final IPrefsService _service;

  const PrefsCacheDatasource(this._service);

  @override
  CacheEntity<T>? get<T extends Object>(String key) {
    final response = _service.get(key: key);

    if (response == null) return null;

    final decodedResponse = jsonDecode(response);
    return CacheAdapter.fromJson<T>(decodedResponse);
  }

  @override
  Future<void> save<T extends Object>(SaveCacheDTO<T> dto) async {
    final cache = CacheEntity.toSave(dto);
    final data = CacheAdapter.toJson(cache);

    final encodedData = jsonEncode(data);

    await _service.save(key: dto.key, data: encodedData);
  }

  @override
  Future<void> delete(String key) async {
    return _service.delete(key: key);
  }

  @override
  Future<void> clear() async {
    return _service.clear();
  }

  @override
  List<String> getKeys() {
    return _service.getKeys();
  }
}
