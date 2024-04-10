import '../../../../core/core.dart';
import '../dtos/clear_cache_dto.dart';
import '../dtos/get_cache_dto.dart';
import '../dtos/save_cache_dto.dart';
import '../types/cache_types.dart';

abstract interface class ICacheRepository {
  Future<GetCacheResponse<T>> findByKey<T extends Object>(GetCacheDTO dto);
  Future<Either<AutoCacheManagerException, Unit>> save<T extends Object>(
    SaveCacheDTO<T> dto,
  );
  Future<Either<AutoCacheManagerException, Unit>> clear(ClearCacheDTO dto);
}
