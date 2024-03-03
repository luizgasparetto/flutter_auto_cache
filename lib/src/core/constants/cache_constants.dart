import '../../modules/cache/domain/enums/invalidation_type.dart';
import '../../modules/cache/domain/enums/storage_type.dart';

class CacheConstants {
  static const defaultInvalidationType = InvalidationType.refresh;
  static const defaultStorageType = StorageType.kvs;
}
