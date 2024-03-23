import '../../../../core/services/storages/kvs/i_prefs_service.dart';
import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/entities/cache_entity.dart';
import '../../infra/datasources/i_prefs_datasource.dart';
import '../adapters/cache_adapter.dart';

class PrefsDatasource implements IPrefsDatasource {
  final IPrefsService _service;

  const PrefsDatasource(this._service);

  @override
  Future<CacheEntity<T>?> findByKey<T extends Object>(String key) async {
    final response = await _service.get<T>(key: key);

    if (response == null) return null;

    return CacheAdapter.fromDto<T>(response);
  }

  @override
  Future<void> save<T extends Object>(SaveCacheDTO<T> dto) async {
    await _service.save<T>(key: dto.key, data: dto.data);
  }

  @override
  Future<void> clear() async {
    return _service.clear();
  }
}
