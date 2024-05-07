import '../../../../core/core.dart';

import '../repositories/i_cache_repository.dart';

abstract interface class ClearCacheUsecase {
  AsyncEither<AutoCacheManagerException, Unit> execute();
}

class ClearCache implements ClearCacheUsecase {
  final ICacheRepository _repository;

  const ClearCache(this._repository);

  @override
  AsyncEither<AutoCacheManagerException, Unit> execute() async {
    return _repository.clear();
  }
}
