import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/domain/services/invalidation/invalidation_cache_context.dart';

import '../repositories/i_cache_repository.dart';
import '../types/cache_types.dart';

abstract class GetCacheUsecase {
  GetCacheResponseType<T> execute<T>({required String key});
}

class GetCache implements GetCacheUsecase {
  final ICacheRepository _repository;

  const GetCache(this._repository);

  @override
  GetCacheResponseType<T> execute<T>({required String key}) async {
    final searchResponse = await _repository.findByKey<T>(key);

    if (searchResponse.isError) {
      return left(searchResponse.error);
    }

    if (searchResponse.isSuccess && searchResponse.success == null) {
      return right(null);
    }

    final cache = searchResponse.success!;

    final validation = InvalidationCacheContext.execute(cache);

    if (validation.isError) {
      return left(validation.error);
    }

    return right(cache);
  }
}
