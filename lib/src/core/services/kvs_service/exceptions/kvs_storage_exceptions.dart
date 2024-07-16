import '../../../errors/auto_cache_error.dart';

/// Exception thrown when there is an error getting data from storage.
///
/// This exception indicates a failure to retrieve data from the KVS (Key-Value Store)
/// storage system. It provides details about the error encountered during the
/// get operation.
final class GetKvsStorageException extends AutoCacheException {
  const GetKvsStorageException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'get_kvs_storage');
}

final class GetListKvsStorageException extends AutoCacheException {
  const GetListKvsStorageException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'get_list_kvs_storage');
}

/// Exception thrown when there is an error retrieving storage keys.
///
/// This exception indicates a failure to retrieve keys from the KVS (Key-Value Store)
/// storage system. It provides details about the error encountered during the
/// key retrieval operation.
final class GetKvsStorageKeysException extends AutoCacheException {
  const GetKvsStorageKeysException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'get_keys_kvs_storage');
}

/// Exception thrown when there is an error saving data to storage.
///
/// This exception indicates a failure to save data to the KVS (Key-Value Store)
/// storage system. It provides details about the error encountered during the
/// save operation.
final class SaveKvsStorageException extends AutoCacheException {
  const SaveKvsStorageException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'save_kvs_storage');
}

/// Exception thrown when there is an error saving data to storage.
///
/// This exception indicates a failure to save data to the KVS (Key-Value Store)
/// storage system. It provides details about the error encountered during the
/// save operation.
final class SaveListKvsStorageException extends AutoCacheException {
  const SaveListKvsStorageException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'save_list_kvs_storage');
}

/// Exception thrown when there is an error deleting data from storage.
///
/// This exception indicates a failure to delete data from the KVS (Key-Value Store)
/// storage system. It provides details about the error encountered during the
/// delete operation.
final class DeleteKvsStorageException extends AutoCacheException {
  const DeleteKvsStorageException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'delete_kvs_storage');
}

/// Exception thrown when there is an error clearing all data from storage.
///
/// This exception indicates a failure to clear all data from the KVS (Key-Value Store)
/// storage system. It provides details about the error encountered during the
/// clear operation.
final class ClearKvsStorageException extends AutoCacheException {
  const ClearKvsStorageException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'clear_kvs_storage');
}
