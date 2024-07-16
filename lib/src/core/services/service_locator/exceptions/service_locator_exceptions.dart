import '../../../errors/auto_cache_error.dart';

/// Exception thrown when a requested service binding is not found.
///
/// This exception indicates that a requested service type was not registered
/// in the service locator. It provides details about the missing service and
/// helps in debugging the issue.
final class BindNotFoundException extends AutoCacheException {
  BindNotFoundException({
    required super.message,
  }) : super(code: 'bind_not_found', stackTrace: StackTrace.current);
}
