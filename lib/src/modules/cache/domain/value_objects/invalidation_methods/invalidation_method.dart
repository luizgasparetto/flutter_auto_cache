import 'package:flutter/foundation.dart';

import '../../enums/invalidation_type.dart';

/// Defines an interface for invalidation methods.
///
/// This abstract class serves as a foundational blueprint for defining different
/// invalidation methods that specify how and when a particular resource should
/// be considered invalid. It ensures that all invalidation methods follow a consistent
/// structure and interface.
///
/// Implementations:
/// - `TTLInvalidationMethod`: Specifies invalidation based on a Time-To-Live (TTL) duration.
@immutable
abstract class InvalidationMethod {
  /// A const constructor for subclasses to ensure they can be const if desired.
  ///
  /// This constructor doesn't do anything by itself but allows subclasses to
  /// inherit a const constructor, enabling them to be declared as const if
  /// they don't have any final fields that require initialization at runtime.
  const InvalidationMethod();

  /// Returns the type of invalidation.
  ///
  /// This method must be overridden by subclasses to return the specific
  /// type of invalidation they represent, ensuring a uniform interface across
  /// all implementations.
  InvalidationType get invalidationType;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvalidationMethod && other.invalidationType == invalidationType;
  }

  @override
  int get hashCode => invalidationType.hashCode;
}
