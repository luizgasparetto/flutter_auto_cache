import '../../../shared/errors/auto_cache_error.dart';
import '../../../shared/functional/either.dart';
import '../../entities/cache_entity.dart';
import 'cache_substitution_strategy.dart';

abstract class ICacheSubstitutionService<CacheType extends CacheEntity, CacheStrategy extends ICacheSubstitutionStrategy> {
  const ICacheSubstitutionService();

  CacheStrategy get strategy;

  CacheType getDataCache(Object data);

  AsyncEither<AutoCacheError, bool> handleAccomodate({required Object data});

  AsyncEither<AutoCacheError, Unit> substitute<T extends Object>(T data) async {
    final accomodateResponse = await handleAccomodate(data: data);

    return accomodateResponse.fold(left, (accomodate) => _handleSizeVerification(accomodate, getDataCache(data)));
  }

  AsyncEither<AutoCacheError, Unit> _handleSizeVerification<T extends Object>(bool canAccomodate, CacheEntity data) async {
    if (canAccomodate) return right(unit);

    return strategy.substitute(data);
  }
}
