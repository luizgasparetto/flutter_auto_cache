import 'dart:math';

import '../../../../../core/core.dart';

import '../../dtos/delete_cache_dto.dart';
import '../../entities/data_cache_entity.dart';
import '../../repositories/i_data_cache_repository.dart';

part './strategies/fifo_substitution_cache_strategy.dart';
part './strategies/random_substitution_cache_strategy.dart';

sealed class ISubstitutionCacheStrategy {
  final IDataCacheRepository repository;

  const ISubstitutionCacheStrategy(this.repository);

  AsyncEither<AutoCacheError, Unit> substitute<T extends Object>(DataCacheEntity<T> value);

  Either<AutoCacheError, String> getCacheKey();

  AsyncEither<AutoCacheError, Unit> deleteDataCache<T extends Object>(String key, DataCacheEntity<T> data) async {
    final response = await repository.delete(DeleteCacheDTO(key: key));

    return response.fold(left, (_) => _handleAccomodate<T>(key, data));
  }

  AsyncEither<AutoCacheError, Unit> _handleAccomodate<T extends Object>(String key, DataCacheEntity<T> data) async {
    final accomodateResponse = repository.accomodateCache(data);

    if (accomodateResponse.isError) return left(accomodateResponse.error);
    if (accomodateResponse.success) return right(unit);

    final keyResponse = this.getCacheKey();

    return keyResponse.fold(left, (newKey) => deleteDataCache(newKey, data));
  }
}
