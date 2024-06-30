import 'dart:math';

import '../../../../../core/core.dart';
import '../../../../../core/services/cache_size_service/i_cache_size_service.dart';

import '../../dtos/delete_cache_dto.dart';
import '../../repositories/i_data_cache_repository.dart';

part './strategies/fifo_substitution_cache_strategy.dart';
part './strategies/random_substitution_cache_strategy.dart';

sealed class ISubstitutionCacheStrategy {
  final IDataCacheRepository repository;
  final ICacheSizeService sizeService;

  const ISubstitutionCacheStrategy(this.repository, this.sizeService);

  AsyncEither<AutoCacheError, Unit> substitute(String value);

  Either<AutoCacheError, String> getCacheKey();

  AsyncEither<AutoCacheError, Unit> deleteDataCache(String key, String value) async {
    final response = await repository.delete(DeleteCacheDTO(key: key));

    return response.fold(left, (_) => _handleAccomodate(key, value));
  }

  AsyncEither<AutoCacheError, Unit> _handleAccomodate(String key, String value) async {
    final canAccomodateResponse = sizeService.canAccomodateCache(value, recursive: true);

    if (canAccomodateResponse.isError) return left(canAccomodateResponse.error);
    if (canAccomodateResponse.success) return right(unit);

    final keyResponse = this.getCacheKey();

    return keyResponse.fold(left, (newKey) => deleteDataCache(newKey, value));
  }
}
