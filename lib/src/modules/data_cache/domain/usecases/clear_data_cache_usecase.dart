import '../../../../core/shared/errors/auto_cache_error.dart';
import '../../../../core/shared/functional/either.dart';
import '../repositories/i_data_cache_repository.dart';

/// Abstract interface for the ClearCache use case.
///
/// This interface defines a method for clearing all cached data.
/// The operation returns an `AsyncResult` type that represents either
/// an [AutoCacheError] in case of failure, or a [Unit] in case of success.
abstract interface class IClearDataCacheUsecase {
  /// Executes the clear cache operation.
  ///
  /// This method is asynchronous and returns an `AsyncResult` which is a type
  /// representing a computation that can either result in an [AutoCacheError]
  /// (in case of failure) or a [Unit] (in case of success). This operation
  /// clears all data stored in the cache.
  AsyncResult<Unit> execute();
}

class ClearDataCacheUsecase implements IClearDataCacheUsecase {
  final IDataCacheRepository _repository;

  const ClearDataCacheUsecase(this._repository);

  @override
  AsyncResult<Unit> execute() async {
    return _repository.clear();
  }
}
