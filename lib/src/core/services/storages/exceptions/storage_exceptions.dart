import '../../../core.dart';

class GetStorageException extends AutoCacheManagerException {
  GetStorageException({required StackTrace stacktrace})
      : super(code: 'get_storage_exception', message: 'Get Storage Exception Message', stackTrace: stacktrace);
}

class SaveStorageException extends AutoCacheManagerException {
  SaveStorageException({required StackTrace stacktrace})
      : super(code: 'save_storage_exception', message: 'Save Storage Exception Message', stackTrace: stacktrace);
}
