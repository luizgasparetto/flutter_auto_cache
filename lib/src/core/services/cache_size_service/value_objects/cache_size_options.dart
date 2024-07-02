// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import '../../../extensions/types/double_extensions.dart';
import '../constants/cache_size_constants.dart';

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
    this.maxKb = CacheSizeConstants.defaultMaxKb,
    this.maxMb = CacheSizeConstants.defaultMaxMb,
  })  : assert(maxKb >= 0, 'maxKb must be non-negative'),
        assert(maxMb > 0, 'maxMb must be non-negative');

  /// Calculates the total cache size in kilobytes.
  ///
  /// This method combines the maxKb and maxMb properties, converts the total cache size into bytes,
  /// and then converts back to megabytes for a comprehensive size in KB.
  ///
  /// Returns:
  ///   The total cache size in kilobytes (double).
  double get totalKb {
    final totalMbBytes = maxMb * CacheSizeConstants.bytesPerMb;
    final totalKbBytes = maxKb * CacheSizeConstants.bytesPerKb;

    final totalBytes = totalMbBytes + totalKbBytes;

    final totalKb = totalBytes.toDouble() / CacheSizeConstants.bytesPerKb;
    return totalKb.roundToDecimal();
  }

  @override
  bool operator ==(covariant CacheSizeOptions other) {
    if (identical(this, other)) return true;

    return other.maxKb == maxKb && other.maxMb == maxMb;
  }

  @override
  int get hashCode => maxKb.hashCode ^ maxMb.hashCode;
}
