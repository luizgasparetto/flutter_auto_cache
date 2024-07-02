import '../../services/cache_size_service/constants/cache_size_constants.dart';

/// Extension on the [String] class to calculate approximate megabytes used.
extension KbStringExtension on String {
  /// Computes the approximate kylobytes occupied by the string.
  ///
  /// Returns the number of kylobytes by dividing the length of the string in bytes
  /// by [CacheSizeConstants.bytesPerKb], rounded to the nearest decimal.
  double get kbUsed {
    final kbPerString = this.codeUnits.length / CacheSizeConstants.bytesPerKb;
    return double.parse(kbPerString.toStringAsFixed(4));
  }
}
