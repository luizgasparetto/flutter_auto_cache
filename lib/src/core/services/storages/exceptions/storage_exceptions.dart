import '../../../core.dart';

class GetStorageException extends AutoCacheManagerException {
  GetStorageException({
    required super.code,
    required super.message,
    required super.stackTrace,
  });
}

class SaveStorageException extends AutoCacheManagerException {
  SaveStorageException({
    required super.code,
    required super.message,
    required super.stackTrace,
  });
}

class GetPrefsStorageException extends GetStorageException {
  GetPrefsStorageException({required super.stackTrace})
      : super(code: 'get_prefs_storage_exception', message: 'Get Prefs Storage exception');
}

class SavePrefsStorageException extends SaveStorageException {
  SavePrefsStorageException({required super.stackTrace})
      : super(code: 'save_prefs_storage_exception', message: 'Save Prefs Storage exception');
}
