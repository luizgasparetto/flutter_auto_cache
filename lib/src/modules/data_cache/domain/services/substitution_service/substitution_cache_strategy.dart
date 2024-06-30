import '../../../../../core/core.dart';
import '../../../../../core/services/cache_size_service/i_cache_size_service.dart';
import '../../dtos/delete_cache_dto.dart';
import '../../repositories/i_data_cache_repository.dart';

typedef SubstitutionCallback = AsyncEither<AutoCacheError, Unit> Function();

abstract class ISubstitutionCacheStrategy {
  final IDataCacheRepository repository;
  final ICacheSizeService sizeService;

  const ISubstitutionCacheStrategy(this.repository, this.sizeService);

  AsyncEither<AutoCacheError, Unit> substitute(String value, SubstitutionCallback callback);

  Either<AutoCacheError, String> getCacheKey();

  AsyncEither<AutoCacheError, Unit> deleteDataCache(String key, String value, SubstitutionCallback callback) async {
    final response = await repository.delete(DeleteCacheDTO(key: key));

    if (response.isError) return left(response.error);

    return response.fold(left, (_) => _handleAccomodate(key, value, callback));
  }

  AsyncEither<AutoCacheError, Unit> _handleAccomodate(String key, String value, SubstitutionCallback callback) async {
    final canAccomodateResponse = sizeService.canAccomodateCache(value, recursive: true);

    if (canAccomodateResponse.isError) return left(canAccomodateResponse.error);
    if (canAccomodateResponse.success) return callback();

    final keyResponse = this.getCacheKey();

    return keyResponse.fold(left, (newKey) => deleteDataCache(newKey, value, callback));
  }
}
