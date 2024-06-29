import 'dart:io';

import '../../core.dart';

import '../../configuration/constants/cache_size_constants.dart';
import 'exceptions/cache_size_exceptions.dart';

part './implementations/cache_size_service.dart';

/// An abstract class defining the interface for cache detail services.
///
/// This interface requires implementing classes to provide functionality
/// for retrieving the total size of cache used by the application.
abstract interface class ICacheSizeService {
  /// Indicates whether cache is available for use.
  ///
  /// This property should return `true` if the cache is available and
  /// `false` otherwise. It helps in determining whether the cache size
  /// can be retrieved.
  bool get isCacheAvailable;

  /// Returns the total cache size used by the application in megabytes (MB).
  ///
  /// The method should asynchronously calculate and return the total size
  /// of the cache used, facilitating the management of application cache.
  ///
  /// Throws a `CacheSizeException` if there is an error in calculating
  /// the cache size.
  double getCacheSizeUsed();
}
