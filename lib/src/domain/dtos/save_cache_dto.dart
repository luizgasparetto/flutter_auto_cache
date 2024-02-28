import '../enums/invalidation_types.dart';

class SaveCacheDTO<T> {
  final String key;
  final T data;
  final InvalidationTypes invalidationType;

  const SaveCacheDTO({
    required this.key,
    required this.data,
    this.invalidationType = InvalidationTypes.refresh,
  });
}
