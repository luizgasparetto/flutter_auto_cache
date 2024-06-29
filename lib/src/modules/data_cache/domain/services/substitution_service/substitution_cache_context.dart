import '../../../../../core/core.dart';

import '../../../../../core/services/cache_size_service/i_cache_size_service.dart';
import '../../enums/substitution_policies.dart';

import '../../repositories/i_data_cache_repository.dart';
import 'strategies/fifo_substitution_cache_strategy.dart';
import 'strategies/random_substitution_cache_strategy.dart';
import 'substitution_cache_strategy.dart';

abstract interface class ISubstitutionCacheService {
  AsyncEither<AutoCacheError, Unit> substitute(SubstitutionCallback callback);
}

final class SubstitutionCacheService implements ISubstitutionCacheService {
  final CacheConfiguration configuration;
  final ICacheSizeService sizeService;
  final IDataCacheRepository repository;

  const SubstitutionCacheService(this.configuration, this.sizeService, this.repository);

  @override
  AsyncEither<AutoCacheError, Unit> substitute(SubstitutionCallback callback) {
    if (sizeService.isCacheAvailable) return callback();

    return _strategy.substitute(callback);
  }

  ISubstitutionCacheStrategy get _strategy {
    return switch (configuration.dataCacheOptions.substitutionPolicy) {
      SubstitutionPolicies.fifo => FifoSubstitutionCacheStrategy(repository),
      SubstitutionPolicies.random => RandomSubstitutionCacheStrategy(repository),
    };
  }
}
