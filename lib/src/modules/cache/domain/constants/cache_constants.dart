import '../enums/invalidation_type.dart';
import '../enums/storage_type.dart';

class CacheConstants {
  static const defaultInvalidationType = InvalidationType.refresh;
  static const defaultStorageType = StorageType.kvs;

  static const defaultMaxKb = 0;
  static const defaultMaxMb = 20;
}
