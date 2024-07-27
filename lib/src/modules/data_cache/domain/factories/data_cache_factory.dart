import '../../../../core/shared/configuration/cache_configuration.dart';
import '../dtos/write_cache_dto.dart';
import '../entities/data_cache_entity.dart';

/// An interface for a data cache factory, providing methods
/// to create, update, and mark data cache entities as used.
///
/// This interface defines methods to:
/// - Save a new data cache entity.
/// - Update an existing data cache entity.
/// - Mark a data cache entity as used.
///
/// The generic type [T] extends [Object] to ensure type safety and flexibility for different data types.
abstract interface class IDataCacheFactory {
  /// Saves a new data cache entity.
  ///
  /// This method takes a [WriteCacheDTO] object containing the data to be cached and
  /// returns a [DataCacheEntity] representing the saved cache entry.
  DataCacheEntity<T> save<T extends Object>(WriteCacheDTO<T> dto);

  /// Updates an existing data cache entity.
  ///
  /// This method takes new data and an existing [DataCacheEntity], and returns an updated
  /// [DataCacheEntity] with the new data.
  DataCacheEntity<T> update<T extends Object>(T data, DataCacheEntity<T> cache);

  /// Marks a data cache entity as used.
  ///
  /// This method updates the usage metadata of a [DataCacheEntity], indicating that it has been accessed or used.
  DataCacheEntity<T> used<T extends Object>(DataCacheEntity<T> cache);
}

final class DataCacheFactory implements IDataCacheFactory {
  final CacheConfiguration configuration;

  const DataCacheFactory(this.configuration);

  @override
  DataCacheEntity<T> save<T extends Object>(WriteCacheDTO<T> dto) {
    return DataCacheEntity(
      id: dto.key,
      data: dto.data,
      createdAt: DateTime.now(),
      endAt: configuration.dataCacheOptions.invalidationMethod.endAt,
    );
  }

  @override
  DataCacheEntity<T> update<T extends Object>(T data, DataCacheEntity<T> cache) {
    return DataCacheEntity<T>(
      id: cache.id,
      data: data,
      usageCount: cache.usageCount,
      createdAt: cache.createdAt,
      endAt: configuration.dataCacheOptions.invalidationMethod.endAt,
      usedAt: cache.usedAt,
      updatedAt: DateTime.now(),
    );
  }

  @override
  DataCacheEntity<T> used<T extends Object>(DataCacheEntity<T> cache) {
    return DataCacheEntity<T>(
      id: cache.id,
      data: cache.data,
      usageCount: cache.usageCount + 1,
      createdAt: cache.createdAt,
      endAt: cache.endAt,
      updatedAt: cache.updatedAt,
      usedAt: DateTime.now(),
    );
  }
}
