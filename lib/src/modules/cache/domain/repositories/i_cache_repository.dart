import '../../../../core/logic/either.dart';

import '../dtos/save_cache_dto.dart';
import '../entities/cache_entity.dart';

abstract class ICacheRepository {
  Future<Either<Exception, CacheEntity>> findById(String key);
  Future<Either<Exception, Unit>> save(SaveCacheDTO dto);
}
