import '../../core/exceptions/cache_manager_exception.dart';

class KeyAlreadyInUseException implements AutoCacheManagerException {
  @override
  String get message =>
      'This key is already in use by another cache item, pick up another key to save your dat or change your invalidation type for one who support replace, like REFRESH';

  @override
  String get errorCode => 'key-already-in-use';

  @override
  StackTrace get stackTrace => StackTrace.current;
}
