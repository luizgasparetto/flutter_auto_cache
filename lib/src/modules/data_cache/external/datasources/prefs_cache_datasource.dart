import 'dart:convert';

import '../../../../core/services/cryptography/i_cryptography_service.dart';
import '../../../../core/services/storages/prefs/i_prefs_service.dart';
import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/entities/cache_entity.dart';
import '../../infra/datasources/i_prefs_cache_datasource.dart';
import '../adapters/cache_adapter.dart';

final class PrefsCacheDatasource implements IPrefsCacheDatasource {
  final IPrefsService _prefsService;
  final ICryptographyService _cryptographyService;

  const PrefsCacheDatasource(this._prefsService, this._cryptographyService);

  @override
  CacheEntity<T>? get<T extends Object>(String key) {
    final response = _prefsService.get(key: key);

    if (response == null) return null;

    final decrypted = _cryptographyService.decrypt(response);

    final decodedResponse = jsonDecode(decrypted);

    return CacheAdapter.fromJson<T>(decodedResponse);
  }

  @override
  Future<void> save<T extends Object>(SaveCacheDTO<T> dto) async {
    final cache = CacheEntity.toSave(dto);
    final data = CacheAdapter.toJson(cache);

    final encodedData = jsonEncode(data);
    final encrypted = _cryptographyService.encrypt(encodedData);

    await _prefsService.save(key: dto.key, data: encrypted);
  }

  @override
  Future<void> delete(String key) async {
    return _prefsService.delete(key: key);
  }

  @override
  Future<void> clear() async {
    return _prefsService.clear();
  }

  @override
  List<String> getKeys() {
    return _prefsService.getKeys();
  }
}
