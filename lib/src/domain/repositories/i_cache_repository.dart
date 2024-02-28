import '../../core/logic/either.dart';

import '../dtos/save_cache_dto.dart';
import '../types/cache_types.dart';

abstract class ICacheRepository {
  GetCacheResponseType<T> findByKey<T>(String key);
  Future<Either<Exception, Unit>> save(SaveCacheDTO dto);
}
