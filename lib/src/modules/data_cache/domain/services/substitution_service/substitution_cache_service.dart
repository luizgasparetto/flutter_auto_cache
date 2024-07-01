import '../../../../../core/core.dart';

import '../../entities/data_cache_entity.dart';
import '../../enums/substitution_policies.dart';

import '../../repositories/i_data_cache_repository.dart';

import 'substitution_cache_strategy.dart';

abstract interface class ISubstitutionCacheService {
  AsyncEither<AutoCacheError, Unit> substitute<T extends Object>(T data);
}

final class SubstitutionCacheService implements ISubstitutionCacheService {
  final CacheConfiguration configuration;
  final IDataCacheRepository repository;

  const SubstitutionCacheService(this.configuration, this.repository);

  @override
  AsyncEither<AutoCacheError, Unit> substitute<T extends Object>(T data) async {
    final dataCache = DataCacheEntity.fakeConfig(data);
    final accomodateResponse = await repository.accomodateCache<T>(dataCache);

    return accomodateResponse.fold(left, (accomodate) => _handleSizeVerification(accomodate, dataCache));
  }

  AsyncEither<AutoCacheError, Unit> _handleSizeVerification<T extends Object>(bool canAccomodate, DataCacheEntity<T> data) async {
    if (canAccomodate) return right(unit);

    return _strategy.substitute(data);
  }

  ISubstitutionCacheStrategy get _strategy {
    return switch (configuration.dataCacheOptions.substitutionPolicy) {
      SubstitutionPolicies.fifo => FifoSubstitutionCacheStrategy(repository),
      SubstitutionPolicies.random => RandomSubstitutionCacheStrategy(repository),
    };
  }
}
