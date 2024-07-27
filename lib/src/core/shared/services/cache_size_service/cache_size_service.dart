import 'dart:io';

import '../../configuration/cache_configuration.dart';
import '../directory_service/directory_provider_service.dart';

import 'constants/cache_size_constants.dart';
import 'exceptions/cache_size_exceptions.dart';

/// An abstract class defining the interface for cache detail services.
///
/// This interface requires implementing classes to provide functionality
/// for retrieving the total size of cache used by the application.
abstract interface class ICacheSizeService {
  /// Checks if the cache can accommodate the specified additional size in kilobytes.
  ///
  /// Returns `true` if the cache can accommodate the additional size specified in kilobytes,
  /// `false` otherwise.
  Future<bool> canAccomodateCache(String value);

  /// Returns the total cache size used by the application in megabytes (MB).
  ///
  /// The method should asynchronously calculate and return the total size
  /// of the cache used, facilitating the management of application cache.
  ///
  /// Throws a `CacheSizeException` if there is an error in calculating
  /// the cache size.
  Future<double> getCacheSizeUsed();
}

final class CacheSizeService implements ICacheSizeService {
  final IDirectoryProviderService directoryProvider;
  final CacheConfiguration config;

  const CacheSizeService(this.directoryProvider, this.config);

  @override
  Future<bool> canAccomodateCache(String value) async {
    final cacheSizeUsed = await this.getCacheSizeUsed();

    final kbUsedByValue = _getKbUsedByString(value);
    final newTotalCacheUsed = cacheSizeUsed + kbUsedByValue;

    return newTotalCacheUsed < config.sizeOptions.totalKb;
  }

  @override
  Future<double> getCacheSizeUsed() async {
    try {
      await directoryProvider.getCacheDirectories();

      final files = directoryProvider.prefsDirectory.listSync(recursive: true);
      final totalBytes = files.whereType<File>().fold(0, (acc, file) => acc + file.lengthSync());

      return totalBytes / CacheSizeConstants.bytesPerKb;
    } catch (exception, stackTrace) {
      throw CalculateCacheSizeException(
        message: 'An error occurred while calculating cache size: ${exception.toString()}',
        stackTrace: stackTrace,
      );
    }
  }

  double _getKbUsedByString(String value) {
    final kbPerString = value.codeUnits.length / CacheSizeConstants.bytesPerKb;
    return double.parse(kbPerString.toStringAsFixed(4));
  }
}
