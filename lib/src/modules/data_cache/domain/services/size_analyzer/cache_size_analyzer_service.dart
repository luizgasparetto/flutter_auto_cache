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
  AsyncEither<AutoCacheFailure, double> getCacheSizeUsed();
}

/// A service class for managing cache details.
///
/// This class provides functionalities to calculate and retrieve
/// the size of cache used by the application. It works by assessing
/// the size of files stored in the application's documents and support
/// directories, typically used for key-value storage (Prefs) and SQL storage.
final class CacheSizeAnalyzerService implements ICacheSizeAnalyzerService {
  final IDirectoryProviderService directoryProvider;

  const CacheSizeAnalyzerService(this.directoryProvider);

  /// Retrieves the total cache size used by the application.
  ///
  /// It calculates the cache size by summing up the sizes of files
  /// in the key-value storage (Prefs) directory and the SQL storage directory.
  /// The sizes are calculated in megabytes (MB) for easier interpretation.
  ///
  /// Returns:
  /// A `Future<double>` representing the total cache size used in megabytes (MB).
  @override
  AsyncEither<AutoCacheFailure, double> getCacheSizeUsed() async {
    try {
      final totalPrefsSize = _calculeCacheSizeInMb(directoryProvider.prefsDirectory);
      final totalSqlSize = _calculeCacheSizeInMb(directoryProvider.sqlDirectory);

      final total = totalSqlSize + totalPrefsSize;

      return right(total);
    } on AutoCacheFailure catch (e) {
      return left(e);
    } catch (_) {
      return left(
        CacheSizeFailure(message: 'Failed to get size of cache'),
      );
    }
  }

  /// Calculates the cache size in megabytes (MB) for a given directory.
  ///
  /// This method iterates through all files in the specified directory,
  /// including subdirectories, to calculate the total size. The size is
  /// then converted to megabytes (MB) for consistency.
  ///
  /// Parameters:
  /// - [directory] A `Directory` instance representing the directory
  ///   whose cache size is to be calculated.
  ///
  /// Returns:
  /// A `double` representing the size of the cache in megabytes (MB).
  double _calculeCacheSizeInMb(Directory directory) {
    try {
      final files = directory.listSync(recursive: true);

      final total = files.whereType<File>().fold(0, (acc, file) => acc + file.lengthSync());
      return total / CacheSizeConstants.bytesPerMb;
    } catch (_) {
      throw CalculateCacheSizeFailure(message: 'Failed to calculate cache size');
    }
  }
}
