import '../constants/cache_constants.dart';
import '../enums/invalidation_type.dart';

class SaveCacheDTO<T> {
  final String key;
  final T data;
  final InvalidationType invalidationType;

  const SaveCacheDTO({
    required this.key,
    required this.data,
    this.invalidationType = CacheConstants.defaultInvalidationType,
  });
}
