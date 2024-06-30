part of '../i_cache_size_service.dart';

/// A service class for managing cache details.
///
/// This class provides functionalities to calculate and retrieve
/// the size of cache used by the application. It works by assessing
/// the size of files stored in the application's documents and support
/// directories, typically used for key-value storage (Prefs).
final class CacheSizeService implements ICacheSizeService {
  final IDirectoryProviderService directoryProvider;
  final CacheConfiguration config;

  const CacheSizeService(this.directoryProvider, this.config);

  @override
  bool canAccomodateCache(String value, {bool recursive = false}) {
    final cacheSizeUsed = this.getCacheSizeUsed();
    final newTotalCacheUsed = cacheSizeUsed + value.kbUsed;

    return newTotalCacheUsed < config.sizeOptions.totalKb;
  }

  @override
  double getCacheSizeUsed() {
    try {
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
}
