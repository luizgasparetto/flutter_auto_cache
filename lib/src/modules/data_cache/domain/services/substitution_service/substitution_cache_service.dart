import '../../../../../core/domain/services/substitution_service/cache_substitution_service.dart';
import '../../../../../core/shared/configuration/cache_configuration.dart';
import '../../../../../core/shared/errors/auto_cache_error.dart';
import '../../../../../core/shared/functional/either.dart';

import '../../entities/data_cache_entity.dart';

import '../../repositories/i_data_cache_repository.dart';

import 'data_cache_substitution_strategy.dart';

/// An interface for a cache service that handles data substitution policies.
///
/// This interface defines a method for substituting data in the cache, which
/// must be implemented by any class that adheres to this interface.
abstract interface class IDataCacheSubstitutionService {
  /// Substitutes data in the cache.
  ///
  /// This method attempts to substitute the given data in the cache and returns
  /// either an error or a success unit wrapped in an [AsyncEither].
  ///
  /// [data]: The data to be substituted in the cache.
  AsyncEither<AutoCacheError, Unit> substitute<T extends Object>(T data);
}

final class DataCacheSubstitutionService<T extends Object>
    extends ICacheSubstitutionService<DataCacheEntity<Object>, IDataCacheSubstitutionStrategy> implements IDataCacheSubstitutionService {
  final CacheConfiguration configuration;
  final IDataCacheRepository dataRepository;
  final ISubstitutionDataCacheRepository substitutionRepository;

  const DataCacheSubstitutionService(this.configuration, this.dataRepository, this.substitutionRepository);

  @override
  DataCacheEntity<T> getDataCache(covariant T data) => DataCacheEntity.fakeConfig(data);

  @override
  AsyncEither<AutoCacheError, bool> handleAccomodate({required covariant T data}) async {
    return substitutionRepository.accomodateCache<T>(getDataCache(data));
  }

  @override
  IDataCacheSubstitutionStrategy get strategy => throw UnimplementedError();
}
