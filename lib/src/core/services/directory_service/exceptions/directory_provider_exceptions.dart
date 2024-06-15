import '../../../core.dart';

class DirectoryProviderException extends AutoCacheManagerException {
  DirectoryProviderException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'directory_provider_exception');
}
