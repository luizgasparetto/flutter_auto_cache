import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// An abstract class defining the interface for cache detail services.
///
/// This interface requires implementing classes to provide functionality
/// for retrieving the total size of cache used by the application.
abstract class ICacheDetailsService {
  /// Returns the total cache size used by the application in megabytes (MB).
  ///
  /// The method should asynchronously calculate and return the total size
  /// of the cache used, facilitating the management of application cache.
  Future<double> getCacheSizeUsed();
}

/// A service class for managing cache details.
///
/// This class provides functionalities to calculate and retrieve
/// the size of cache used by the application. It works by assessing
/// the size of files stored in the application's documents and support
/// directories, typically used for key-value storage (KVS) and SQL storage.
sealed class CacheDetailsService implements ICacheDetailsService {
  /// Retrieves the total cache size used by the application.
  ///
  /// It calculates the cache size by summing up the sizes of files
  /// in the key-value storage (KVS) directory and the SQL storage directory.
  /// The sizes are calculated in megabytes (MB) for easier interpretation.
  ///
  /// Returns:
  /// A `Future<double>` representing the total cache size used in megabytes (MB).
  @override
  Future<double> getCacheSizeUsed() async {
    final kvsDirectory = await getApplicationDocumentsDirectory();
    final sqlDirectory = await getApplicationSupportDirectory();

    final totalKvsSize = _calculeCacheSizeInMb(kvsDirectory);
    final totalSqlSize = _calculeCacheSizeInMb(sqlDirectory);

    return totalSqlSize + totalKvsSize;
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
    final files = directory.listSync(recursive: true);

    final total = files.whereType<File>().fold(0, (acc, file) => acc + file.lengthSync());

    return total / (1024 * 1024);
  }
}
