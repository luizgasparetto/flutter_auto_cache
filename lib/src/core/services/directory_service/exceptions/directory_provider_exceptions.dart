import '../../../errors/auto_cache_error.dart';

/// An exception that is thrown when an error occurs in the Directory Provider.
///
/// This exception extends the `AutoCacheException` and includes additional
/// context such as a custom error code.
final class DirectoryProviderException extends AutoCacheException {
  DirectoryProviderException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'directory_provider_exception');
}
