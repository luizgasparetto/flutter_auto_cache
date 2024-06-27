import '../../../../core/core.dart';

import '../dtos/delete_cache_dto.dart';
import '../repositories/i_data_cache_repository.dart';

/// Interface for deleting data from the cache.
///
/// This interface defines a method for deleting cached data based on the provided
/// [DeleteCacheDTO] data transfer object. The operation returns an `AsyncEither`
/// type that represents either an [AutoCacheError] in case of failure, or a [Unit]
/// in case of success.
abstract interface class IDeleteDataCacheUsecase {
  /// Deletes cached data based on the provided [dto].
  ///
  /// This method is asynchronous and returns an `AsyncEither` which is a type
  /// representing a computation that can either result in an `AutoCacheError`
  /// (in case of failure) or a [Unit] (in case of success). The [dto] parameter
  /// encapsulates the necessary information for identifying which cache data
  /// should be deleted.
  AsyncEither<AutoCacheError, Unit> execute(DeleteCacheDTO dto);
}

class DeleteDataCacheUsecase implements IDeleteDataCacheUsecase {
  final IDataCacheRepository _repository;

  const DeleteDataCacheUsecase(this._repository);

  @override
  AsyncEither<AutoCacheError, Unit> execute(DeleteCacheDTO dto) async {
    return _repository.delete(dto);
  }
}
