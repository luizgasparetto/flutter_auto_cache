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

class GetKVSStorageException extends SaveStorageException {
  GetKVSStorageException({required super.stackTrace})
      : super(code: 'get_kvs_storage_exception', message: 'Get KVS Storage exception');
}

class SaveKVSStorageException extends SaveStorageException {
  SaveKVSStorageException({required super.stackTrace})
      : super(code: 'save_kvs_storage_exception', message: 'Save KVS Storage exception');
}
