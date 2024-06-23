import '../../../../core/core.dart';

import '../repositories/i_data_cache_repository.dart';

/// Abstract interface for the ClearCache use case.
abstract interface class ClearCacheUsecase {
  /// Executes the clear cache operation.
  ///
  /// Returns an [AsyncEither] containing either an [AutoCacheError]
  /// or a [Unit] upon completion.
  AsyncEither<AutoCacheError, Unit> execute();
}

/// Implementation of the [ClearCacheUsecase].
class ClearCache implements ClearCacheUsecase {
  final IDataCacheRepository _repository;

  const ClearCache(this._repository);

  @override
  AsyncEither<AutoCacheError, Unit> execute() async {
    return _repository.clear();
  }
}
