import '../../../../core/core.dart';

import '../repositories/i_cache_repository.dart';

abstract interface class ClearCacheUsecase {
  AsyncEither<AutoCacheError, Unit> execute();
}

class ClearCache implements ClearCacheUsecase {
  final ICacheRepository _repository;

  const ClearCache(this._repository);

  @override
  AsyncEither<AutoCacheError, Unit> execute() async {
    return _repository.clear();
  }
}
