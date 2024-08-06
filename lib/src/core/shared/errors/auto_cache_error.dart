/// Represents a failure in the auto cache system.
///
/// This abstract class extends [AutoCacheError] and provides
/// additional context specific to failures within the auto cache system.
abstract class AutoCacheFailure extends AutoCacheError {
  AutoCacheFailure({
    required super.message,
    required super.code,
  }) : super(stackTrace: StackTrace.empty);
}

/// A base class for representing exceptions in the application.
///
/// This class extends [AutoCacheError] and implements [Exception] to define specific types of exceptions.
/// Each exception must provide a [message], [code], and a [stackTrace].
abstract class AutoCacheException extends AutoCacheError implements Exception {
  AutoCacheException({
    required super.message,
    required super.code,
    required super.stackTrace,
  });
}

/// A base class for representing errors in the application.
///
/// This class defines the structure for error handling, including a [message], [stackTrace], and [code].
sealed class AutoCacheError {
  /// The message describing the error.
  final String message;

  /// The [StackTrace] used to reference the error log.
  final StackTrace stackTrace;

  /// The code of the error, used to identify the type of error without knowing the specific implementation.
  final String code;

  AutoCacheError({
    required this.message,
    required this.code,
    required this.stackTrace,
  });
}
