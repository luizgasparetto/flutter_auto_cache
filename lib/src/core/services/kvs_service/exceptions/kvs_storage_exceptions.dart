import '../../../core.dart';

/// Exception thrown when there is an error getting data from storage.
final class GetKvsStorageException extends AutoCacheException {
  /// Creates an instance of [GetKvsStorageException].
  ///
  /// The [code], [message], and [stackTrace] parameters are required.
  const GetKvsStorageException({
    required super.code,
    required super.message,
    required super.stackTrace,
  });
}

/// Exception thrown when there is an error retrieving storage keys.
final class GetKvsStorageKeysException extends AutoCacheException {
  /// Creates an instance of [GetKvsStorageKeysException].
  ///
  /// The [code], [message], and [stackTrace] parameters are required.
  const GetKvsStorageKeysException({
    required super.code,
    required super.message,
    required super.stackTrace,
  });
}

/// Exception thrown when there is an error saving data to storage.
final class SaveKvsStorageException extends AutoCacheException {
  /// Creates an instance of [SaveKvsStorageException].
  ///
  /// The [code], [message], and [stackTrace] parameters are required.
  const SaveKvsStorageException({
    required super.code,
    required super.message,
    required super.stackTrace,
  });
}

/// Exception thrown when there is an error deleting data from storage.
final class DeleteKvsStorageException extends AutoCacheException {
  /// Creates an instance of [DeleteKvsStorageException].
  ///
  /// The [code], [message], and [stackTrace] parameters are required.
  const DeleteKvsStorageException({
    required super.code,
    required super.message,
    required super.stackTrace,
  });
}

/// Exception thrown when there is an error clearing all data from storage.
final class ClearKvsStorageException extends AutoCacheException {
  /// Creates an instance of [ClearKvsStorageException].
  ///
  /// The [code], [message], and [stackTrace] parameters are required.
  const ClearKvsStorageException({
    required super.code,
    required super.message,
    required super.stackTrace,
  });
}
