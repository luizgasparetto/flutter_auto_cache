part 'specifications/ttl_invalidation_method.dart';

/// A sealed class representing different invalidation methods.
///
/// This class serves as a base for various invalidation strategies.
/// It defines a common interface for obtaining the end time of an invalidation.
sealed class InvalidationMethod {
  const InvalidationMethod();

  /// Gets the date and time when the invalidation should end.
  ///
  /// This method should be overridden by subclasses to provide specific
  /// invalidation logic. The current implementation uses a switch case
  /// to determine the appropriate end time based on the subclass.
  DateTime get endAt {
    return switch (this) {
      TTLInvalidationMethod ttl => ttl.endAt,
    };
  }
}
