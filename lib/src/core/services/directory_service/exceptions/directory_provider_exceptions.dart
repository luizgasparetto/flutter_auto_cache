import '../../../core.dart';

/// An exception that is thrown when an error occurs in the Directory Provider.
///
/// This exception extends the `AutoCacheException` and includes additional
/// context such as a custom error code.
///
/// - [message]: A string describing the error.
/// - [stackTrace]: The stack trace at the point where the exception was thrown.
class DirectoryProviderException extends AutoCacheException {
  /// Creates a new `DirectoryProviderException`.
  ///
  /// - [message]: A string describing the error.
  /// - [stackTrace]: The stack trace at the point where the exception was thrown.
  DirectoryProviderException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'directory_provider_exception');
}
