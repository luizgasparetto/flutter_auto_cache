import '../../../errors/auto_cache_error.dart';

/// Exception thrown when there is an error getting data from storage.
///
/// This exception indicates a failure to retrieve data from the KVS (Key-Value Store) storage
/// storage system. It provides details about the error encountered during the
/// get operation.
final class GetStorageStorageException extends AutoCacheException {
  GetStorageStorageException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'get_storage');
}

final class GetListStorageStorageException extends AutoCacheException {
  GetListStorageStorageException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'get_list_storage');
}

/// Exception thrown when there is an error retrieving storage keys.
///
/// This exception indicates a failure to retrieve keys from the KVS (Key-Value Store) storage
/// storage system. It provides details about the error encountered during the
/// key retrieval operation.
final class GetStorageStorageKeysException extends AutoCacheException {
  GetStorageStorageKeysException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'get_keys_storage');
}

/// Exception thrown when there is an error saving data to storage.
///
/// This exception indicates a failure to save data to the KVS (Key-Value Store) storage
/// storage system. It provides details about the error encountered during the
/// save operation.
final class SaveStorageStorageException extends AutoCacheException {
  SaveStorageStorageException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'save_storage');
}

/// Exception thrown when there is an error saving data to storage.
///
/// This exception indicates a failure to save data to the KVS (Key-Value Store) storage
/// storage system. It provides details about the error encountered during the
/// save operation.
final class SaveListStorageStorageException extends AutoCacheException {
  SaveListStorageStorageException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'save_list_storage');
}

/// Exception thrown when there is an error deleting data from storage.
///
/// This exception indicates a failure to delete data from the KVS (Key-Value Store) storage
/// storage system. It provides details about the error encountered during the
/// delete operation.
final class DeleteStorageStorageException extends AutoCacheException {
  DeleteStorageStorageException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'delete_storage');
}

/// Exception thrown when there is an error clearing all data from storage.
///
/// This exception indicates a failure to clear all data from the KVS (Key-Value Store) storage
/// storage system. It provides details about the error encountered during the
/// clear operation.
final class ClearStorageStorageException extends AutoCacheException {
  ClearStorageStorageException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'clear_storage');
}
