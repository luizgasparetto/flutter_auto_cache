import '../configuration/constants/cache_size_constants.dart';

import 'double_extensions.dart';

/// Extension on the [String] class to calculate approximate megabytes used.
extension MbStringExtension on String {
  /// Computes the approximate megabytes occupied by the string.
  ///
  /// Returns the number of megabytes by dividing the length of the string in bytes
  /// by [CacheSizeConstants.bytesPerMb], rounded to the nearest decimal.
  double get mbUsed {
    return (this.codeUnits.length / CacheSizeConstants.bytesPerMb).roundToDecimal();
  }
}
