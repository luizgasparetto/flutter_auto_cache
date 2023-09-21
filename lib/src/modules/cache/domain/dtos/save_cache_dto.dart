import '../enums/invalidation_types.dart';

class SaveCacheDTO<T> {
  final String id;
  final T data;
  final InvalidationTypes invalidationTypes;

  const SaveCacheDTO({
    required this.id,
    required this.data,
    required this.invalidationTypes,
  });
}
