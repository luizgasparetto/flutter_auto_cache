import 'dart:math';

import '../../../../../../core/core.dart';
import '../../../dtos/delete_cache_dto.dart';
import '../../../repositories/i_data_cache_repository.dart';
import '../substitution_cache_strategy.dart';

final class RandomSubstitutionCacheStrategy implements ISubstitutionCacheStrategy {
  final IDataCacheRepository _repository;

  const RandomSubstitutionCacheStrategy(this._repository);

  @override
  AsyncEither<AutoCacheError, Unit> substitute(SubstitutionCallback callback) async {
    final keysResponse = _repository.getKeys();
    return keysResponse.fold(left, (keys) => _deleteRandomCache(keys, callback));
  }

  AsyncEither<AutoCacheError, Unit> _deleteRandomCache(List<String> keys, SubstitutionCallback callback) async {
    final randomIndex = Random().nextInt(keys.length);
    final dataCacheKey = keys[randomIndex];

    final response = await _repository.delete(DeleteCacheDTO(key: dataCacheKey));
    return response.fold(left, (_) => callback());
  }
}
