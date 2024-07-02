import 'dart:io';

import '../../core.dart';

import '../../extensions/types/string_extensions.dart';

import '../../configuration/constants/cache_size_constants.dart';
import '../directory_service/directory_provider_service.dart';
import 'exceptions/cache_size_exceptions.dart';

part './implementations/cache_size_service.dart';

/// An abstract class defining the interface for cache detail services.
///
/// This interface requires implementing classes to provide functionality
/// for retrieving the total size of cache used by the application.
abstract interface class ICacheSizeService {
  /// Checks if the cache can accommodate the specified additional size in kilobytes.
  ///
  /// Returns `true` if the cache can accommodate the additional size specified in kilobytes,
  /// `false` otherwise.
  Future<bool> canAccomodateCache(String value, {bool recursive = false});

  /// Returns the total cache size used by the application in megabytes (MB).
  ///
  /// The method should asynchronously calculate and return the total size
  /// of the cache used, facilitating the management of application cache.
  ///
  /// Throws a `CacheSizeException` if there is an error in calculating
  /// the cache size.
  Future<double> getCacheSizeUsed();
}
