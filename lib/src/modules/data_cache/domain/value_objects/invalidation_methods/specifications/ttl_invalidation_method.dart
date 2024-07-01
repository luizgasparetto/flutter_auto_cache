part of '../invalidation_method.dart';

/// A class representing the Time-To-Live (TTL) invalidation method.
///
/// This class extends [InvalidationMethod] and provides an implementation
/// for invalidation based on a maximum duration.
final class TTLInvalidationMethod extends InvalidationMethod {
  /// The maximum duration for the TTL invalidation.
  ///
  /// Defaults to a duration of 1 day if not provided.
  final Duration maxDuration;

  /// Creates a [TTLInvalidationMethod] with an optional [maxDuration].
  ///
  /// If [maxDuration] is not provided, it defaults to 1 day.
  const TTLInvalidationMethod([this.maxDuration = const Duration(days: 1)]);

  @override
  DateTime get endAt => DateTime.now().add(maxDuration);
}
