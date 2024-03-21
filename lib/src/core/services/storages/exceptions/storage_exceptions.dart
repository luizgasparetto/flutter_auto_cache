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

class GetPREFSStorageException extends SaveStorageException {
  GetPREFSStorageException({required super.stackTrace})
      : super(code: 'get_prefs_storage_exception', message: 'Get PREFS Storage exception');
}

class SavePREFSStorageException extends SaveStorageException {
  SavePREFSStorageException({required super.stackTrace})
      : super(code: 'save_prefs_storage_exception', message: 'Save PREFS Storage exception');
}
