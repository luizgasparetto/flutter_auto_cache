import 'dart:io';

import '../../../../../core/core.dart';
import '../../../../../core/config/constants/cache_size_constants.dart';
import '../../failures/cache_size_failures.dart';

/// An abstract class defining the interface for cache detail services.
///
/// This interface requires implementing classes to provide functionality
/// for retrieving the total size of cache used by the application.
abstract interface class ICacheSizeAnalyzerService {
  /// Returns the total cache size used by the application in megabytes (MB).
  ///
  /// The method should asynchronously calculate and return the total size
  /// of the cache used, facilitating the management of application cache.
  Either<AutoCacheFailure, double> getCacheSizeUsed();
}

/// A service class for managing cache details.
///
/// This class provides functionalities to calculate and retrieve
/// the size of cache used by the application. It works by assessing
/// the size of files stored in the application's documents and support
/// directories, typically used for key-value storage (Prefs) and SQL storage.
final class CacheSizeAnalyzerService implements ICacheSizeAnalyzerService {
  final IDirectoryProviderService directoryProvider;
  final CacheConfig config;

  const CacheSizeAnalyzerService(this.directoryProvider, this.config);

  /// Retrieves the total cache size used by the application.
  ///
  /// It calculates the cache size by summing up the sizes of files
  /// in the key-value storage (Prefs) directory and the SQL storage directory.
  /// The sizes are calculated in megabytes (MB) for easier interpretation.
  ///
  /// Returns:
  /// A `Future<double>` representing the total cache size used in megabytes (MB).
  @override
  Either<AutoCacheFailure, double> getCacheSizeUsed() {
    try {
      final files = directoryProvider.prefsDirectory.listSync(recursive: true);
      final totalBytes = files.whereType<File>().fold(0, (acc, file) => acc + file.lengthSync());

      final total = totalBytes / CacheSizeConstants.bytesPerMb;

      return right(total);
    } catch (_) {
      return left(const CalculateCacheSizeFailure(message: 'Failed to calculate cache size'));
    }
  }
}
