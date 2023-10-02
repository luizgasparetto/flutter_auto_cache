import '../enums/invalidation_types.dart';

class SaveCacheDTO<T> {
  final String id;
  final T data;
  final InvalidationTypes invalidationType;

  const SaveCacheDTO({
    required this.id,
    required this.data,
    this.invalidationType = InvalidationTypes.refresh,
  });
}
