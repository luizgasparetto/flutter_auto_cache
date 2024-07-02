/// Extension on [DateTime] to provide additional functionality.
///
/// This extension adds a method to the [DateTime] class that allows creating
/// a new [DateTime] instance with the milliseconds set to zero. This can be
/// useful for situations where millisecond precision is not required or for
/// comparisons where milliseconds should be ignored.
extension MillisecondsDateTimeExtension on DateTime {
  /// Returns a new [DateTime] instance with the milliseconds set to zero.
  ///
  /// This method creates a new [DateTime] object based on the current instance
  /// but with the milliseconds value set to zero. This can be useful in cases
  /// where millisecond precision is not needed or when comparing [DateTime]
  /// instances without considering milliseconds.
  DateTime withoutMilliseconds() {
    return DateTime(this.year, this.month, this.day, this.hour, this.minute, this.second, 0);
  }
}
