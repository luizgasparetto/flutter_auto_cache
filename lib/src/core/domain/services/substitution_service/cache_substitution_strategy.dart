import '../../../shared/errors/auto_cache_error.dart';
import '../../../shared/functional/either.dart';
import '../../entities/cache_entity.dart';

abstract class ICacheSubstitutionStrategy {
  const ICacheSubstitutionStrategy();

  Either<AutoCacheError, String> getCacheKey({bool recursive = false});

  AsyncEither<AutoCacheError, Unit> delete({required String key});

  AsyncEither<AutoCacheException, bool> accomodate(CacheEntity data, {required String key});

  AsyncEither<AutoCacheError, Unit> substitute<T extends Object>(CacheEntity value) {
    final keyResponse = this.getCacheKey();
    return keyResponse.fold(left, (key) => _handleDelete<T>(key, value));
  }

  AsyncEither<AutoCacheError, Unit> _handleDelete<T extends Object>(String key, CacheEntity data) async {
    final response = await delete(key: key);

    return response.fold(left, (_) => _handleAccomodate<T>(key, data));
  }

  AsyncEither<AutoCacheError, Unit> _handleAccomodate<T extends Object>(String key, CacheEntity data) async {
    final accomodateResponse = await accomodate(data, key: key);

    if (accomodateResponse.isError) return left(accomodateResponse.error);
    if (accomodateResponse.success) return right(unit);

    final keyResponse = this.getCacheKey(recursive: true);

    return keyResponse.fold(left, (newKey) => _handleDelete(newKey, data));
  }
}
