import '../../../../../core/core.dart';

import '../../../../../core/services/cache_size_service/i_cache_size_service.dart';

import '../../entities/data_cache_entity.dart';
import '../../enums/substitution_policies.dart';

import '../../repositories/i_data_cache_repository.dart';

import 'substitution_cache_strategy.dart';

abstract interface class ISubstitutionCacheService {
  AsyncEither<AutoCacheError, Unit> substitute<T extends Object>(T data);
}

final class SubstitutionCacheService implements ISubstitutionCacheService {
  final CacheConfiguration configuration;
  final ICacheSizeService sizeService;
  final IDataCacheRepository repository;

  const SubstitutionCacheService(this.configuration, this.sizeService, this.repository);

  @override
  AsyncEither<AutoCacheError, Unit> substitute<T extends Object>(T data) async {
    final dataCache = DataCacheEntity.fakeConfig(data);
    final encryptedValue = repository.getEncryptedData(dataCache);

    return encryptedValue.fold(left, (value) => _handleSizeVerification(value));
  }

  AsyncEither<AutoCacheError, Unit> _handleSizeVerification(String value) async {
    final response = sizeService.canAccomodateCache(value);

    return response.fold(left, (canAccomodate) => canAccomodate ? right(unit) : _strategy.substitute(value));
  }

  ISubstitutionCacheStrategy get _strategy {
    return switch (configuration.dataCacheOptions.substitutionPolicy) {
      SubstitutionPolicies.fifo => FifoSubstitutionCacheStrategy(repository, sizeService),
      SubstitutionPolicies.random => RandomSubstitutionCacheStrategy(repository, sizeService),
    };
  }
}
