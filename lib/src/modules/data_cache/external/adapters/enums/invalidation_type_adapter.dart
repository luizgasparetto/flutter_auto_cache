import '../../../domain/enums/invalidation_type.dart';

/// A utility class responsible for converting between string keys and [InvalidationType] enumerations.
///
/// The [InvalidationTypeAdapter] class provides methods to map string representations
/// to enumeration values and vice versa. It facilitates consistent and type-safe conversions
/// for cache invalidation types.
class InvalidationTypeAdapter {
  /// Converts a string key into an [InvalidationType] enumeration value.
  ///
  /// This method matches the given string key to a corresponding [InvalidationType] value.
  /// If no matching key is found, the method returns a default value of [InvalidationType.refresh].
  ///
  /// - Parameter [key]: A `String` representing the key associated with an invalidation type.
  ///
  /// - Returns: An [InvalidationType] value that corresponds to the provided key,
  ///            or the default [InvalidationType.refresh] if no match is found.
  static InvalidationType fromKey(String key) {
    return switch (key) {
      'refresh' => InvalidationType.refresh,
      'ttl' => InvalidationType.ttl,
      _ => InvalidationType.refresh,
    };
  }

  /// Converts an [InvalidationType] enumeration value into its string representation.
  ///
  /// This method maps a given [InvalidationType] value to its corresponding string key,
  /// ensuring consistency in serializations.
  ///
  /// - Parameter [type]: An [InvalidationType] enumeration value to be converted.
  ///
  /// - Returns: A `String` that represents the key associated with the given invalidation type.
  static String toKey(InvalidationType type) {
    return switch (type) {
      InvalidationType.refresh => 'refresh',
      InvalidationType.ttl => 'ttl',
    };
  }
}
