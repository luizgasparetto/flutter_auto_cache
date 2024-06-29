import '../../../../../../core/core.dart';
import '../../../dtos/delete_cache_dto.dart';
import '../../../repositories/i_data_cache_repository.dart';
import '../substitution_cache_strategy.dart';

final class FifoSubstitutionCacheStrategy implements ISubstitutionCacheStrategy {
  final IDataCacheRepository _repository;

  const FifoSubstitutionCacheStrategy(this._repository);

  @override
  AsyncEither<AutoCacheError, Unit> substitute(SubstitutionCallback callback) async {
    final keysResponse = _repository.getKeys();
    return keysResponse.fold(left, (keys) => _deleteFirstCache(keys, callback));
  }

  AsyncEither<AutoCacheError, Unit> _deleteFirstCache(List<String> keys, SubstitutionCallback callback) async {
    final dataCacheKey = keys.first;
    final response = await _repository.delete(DeleteCacheDTO(key: dataCacheKey));

    return response.fold(left, (_) => callback());
  }
}
