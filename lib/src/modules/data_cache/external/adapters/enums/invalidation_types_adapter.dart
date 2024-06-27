import '../../../domain/enums/invalidation_types.dart';

/// A utility class responsible for converting between string keys and [InvalidationTypes] enumerations.
///
/// The [InvalidationTypesAdapter] class provides methods to map string representations
/// to enumeration values and vice versa. It facilitates consistent and type-safe conversions
/// for cache invalidation types.
final class InvalidationTypesAdapter {
  /// Converts a string key into an [InvalidationTypes] enumeration value.
  ///
  /// This method matches the given string key to a corresponding [InvalidationTypes] value.
  /// If no matching key is found, the method returns a default value of [InvalidationTypes.refresh].
  ///
  /// - Parameter [key]: A `String` representing the key associated with an invalidation type.
  ///
  /// - Returns: An [InvalidationTypes] value that corresponds to the provided key,
  ///            or the default [InvalidationTypes.refresh] if no match is found.
  static InvalidationTypes fromKey(String key) {
    return switch (key) {
      'refresh' => InvalidationTypes.refresh,
      'ttl' => InvalidationTypes.ttl,
      _ => InvalidationTypes.refresh,
    };
  }

  /// Converts an [InvalidationTypes] enumeration value into its string representation.
  ///
  /// This method maps a given [InvalidationTypes] value to its corresponding string key,
  /// ensuring consistency in serializations.
  ///
  /// - Parameter [type]: An [InvalidationTypes] enumeration value to be converted.
  ///
  /// - Returns: A `String` that represents the key associated with the given invalidation type.
  static String toKey(InvalidationTypes type) {
    return switch (type) {
      InvalidationTypes.refresh => 'refresh',
      InvalidationTypes.ttl => 'ttl',
    };
  }
}
