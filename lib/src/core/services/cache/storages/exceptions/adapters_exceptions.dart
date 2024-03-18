import '../../../../core.dart';

class StorageAdapterException extends AutoCacheManagerException {
  const StorageAdapterException({
    required super.code,
    required super.message,
    required super.stackTrace,
  });
}
