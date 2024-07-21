import '../../../../../core/configuration/cache_configuration.dart';
import '../../../../../core/errors/auto_cache_error.dart';
import '../../../../../core/functional/either.dart';

import '../../entities/data_cache_entity.dart';
import '../../enums/substitution_policies.dart';

import '../../repositories/i_data_cache_repository.dart';

import 'substitution_cache_strategy.dart';

/// An interface for a cache service that handles data substitution policies.
///
/// This interface defines a method for substituting data in the cache, which
/// must be implemented by any class that adheres to this interface.
abstract interface class ISubstitutionCacheService {
  /// Substitutes data in the cache.
  ///
  /// This method attempts to substitute the given data in the cache and returns
  /// either an error or a success unit wrapped in an [AsyncEither].
  ///
  /// [data]: The data to be substituted in the cache.
  AsyncEither<AutoCacheError, Unit> substitute<T extends Object>(T data);
}

final class SubstitutionCacheService implements ISubstitutionCacheService {
  final CacheConfiguration configuration;
  final IDataCacheRepository dataRepository;
  final ISubstituteDataCacheRepository substituteRepository;

  const SubstitutionCacheService(this.configuration, this.dataRepository, this.substituteRepository);

  @override
  AsyncEither<AutoCacheError, Unit> substitute<T extends Object>(T data) async {
    final dataCache = DataCacheEntity.fakeConfig(data);
    final accomodateResponse = await substituteRepository.accomodateCache<T>(dataCache);

    return accomodateResponse.fold(left, (accomodate) => _handleSizeVerification(accomodate, dataCache));
  }

  AsyncEither<AutoCacheError, Unit> _handleSizeVerification<T extends Object>(bool canAccomodate, DataCacheEntity<T> data) async {
    if (canAccomodate) return right(unit);

    return _strategy.substitute(data);
  }

  ISubstitutionCacheStrategy get _strategy {
    return switch (configuration.dataCacheOptions.substitutionPolicy) {
      SubstitutionPolicies.fifo => FifoSubstitutionCacheStrategy(dataRepository, substituteRepository),
      SubstitutionPolicies.lru => LruSubstitutionCacheStrategy(dataRepository, substituteRepository),
      SubstitutionPolicies.random => RandomSubstitutionCacheStrategy(dataRepository, substituteRepository),
    };
  }
}
