import 'package:flutter/foundation.dart';

/// Represents cache size options with configurable maximum sizes in kilobytes (KB) and megabytes (MB).
///
/// This class allows the definition of cache size limits for applications that require management
/// of memory or disk cache sizes. It provides a flexible way to set these limits and calculate the
/// total cache size in bytes.
@immutable
class CacheSizeOptions {
  /// The maximum cache size in kilobytes. Defaults to 0 KB.
  final int maxKb;

  /// The maximum cache size in megabytes. Defaults to 20 MB.
  final int maxMb;

  /// Constructor for creating cache size options with customizable maximum sizes.
  /// If no values are provided, it defaults to 0 KB for maxKb and 20 MB for maxMb.
  ///
  /// - Parameters:
  ///   - maxKb: The maximum cache size in kilobytes. Must be non-negative.
  ///   - maxMb: The maximum cache size in megabytes. Must be non-negative.
  const CacheSizeOptions({
    this.maxKb = 0,
    this.maxMb = 20,
  })  : assert(maxKb >= 0, 'maxKb must be non-negative'),
        assert(maxMb >= 0, 'maxMb must be non-negative');

  /// Factory constructor to create a default cache size option instance.
  /// This is a convenience method that returns a CacheSizeOptions instance with default values.
  ///
  /// Returns:
  ///   A CacheSizeOptions instance with default settings (0 KB and 20 MB).
  factory CacheSizeOptions.createDefault() => const CacheSizeOptions();

  /// Calculates the total cache size in megabytes.
  ///
  /// This method combines the maxKb and maxMb properties, converts the total cache size into bytes,
  /// and then converts back to megabytes for a comprehensive size in MB.
  ///
  /// Returns:
  ///   The total cache size in megabytes (double).
  double get totalMb {
    final totalMbBytes = maxMb * _bytesPerMb;
    final totalKbBytes = maxKb * _bytesPerKb;

    final total = totalMbBytes + totalKbBytes;

    // Convert the total bytes back to megabytes for the return value.
    return total.toDouble() / _bytesPerMb;
  }

  // Private getter for bytes per kilobyte, representing the number of bytes in one kilobyte.
  int get _bytesPerKb => 1024;

  // Private getter for bytes per megabyte, representing the number of bytes in one megabyte.
  // This is calculated as 1024 kilobytes per megabyte.
  int get _bytesPerMb => _bytesPerKb * 1024;

  @override
  bool operator ==(covariant CacheSizeOptions other) {
    if (identical(this, other)) return true;

    return other.maxKb == maxKb && other.maxMb == maxMb;
  }

  @override
  int get hashCode => maxKb.hashCode ^ maxMb.hashCode;
}
