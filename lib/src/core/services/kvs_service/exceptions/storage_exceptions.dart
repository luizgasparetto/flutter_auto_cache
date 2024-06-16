import '../../../core.dart';

/// Exception thrown when there is an error getting data from storage.
final class GetStorageException extends AutoCacheException {
  /// Creates an instance of [GetStorageException].
  ///
  /// The [code], [message], and [stackTrace] parameters are required.
  GetStorageException({
    required super.code,
    required super.message,
    required super.stackTrace,
  });
}

/// Exception thrown when there is an error retrieving storage keys.
final class GetStorageKeysException extends AutoCacheException {
  /// Creates an instance of [GetStorageKeysException].
  ///
  /// The [code], [message], and [stackTrace] parameters are required.
  GetStorageKeysException({
    required super.code,
    required super.message,
    required super.stackTrace,
  });
}

/// Exception thrown when there is an error saving data to storage.
final class SaveStorageException extends AutoCacheException {
  /// Creates an instance of [SaveStorageException].
  ///
  /// The [code], [message], and [stackTrace] parameters are required.
  SaveStorageException({
    required super.code,
    required super.message,
    required super.stackTrace,
  });
}

/// Exception thrown when there is an error deleting data from storage.
final class DeleteStorageException extends AutoCacheException {
  /// Creates an instance of [DeleteStorageException].
  ///
  /// The [code], [message], and [stackTrace] parameters are required.
  DeleteStorageException({
    required super.code,
    required super.message,
    required super.stackTrace,
  });
}

/// Exception thrown when there is an error clearing all data from storage.
final class ClearStorageException extends AutoCacheException {
  /// Creates an instance of [ClearStorageException].
  ///
  /// The [code], [message], and [stackTrace] parameters are required.
  ClearStorageException({
    required super.code,
    required super.message,
    required super.stackTrace,
  });
}
