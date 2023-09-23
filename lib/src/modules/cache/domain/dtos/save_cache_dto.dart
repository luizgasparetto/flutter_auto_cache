import '../enums/invalidation_types.dart';

class SaveCacheDTO<T> {
  final String id;
  final T data;
  final InvalidationTypes invalidationType;
  final bool autogenerateId;

  const SaveCacheDTO({
    required this.id,
    required this.data,
    this.autogenerateId = false,
    this.invalidationType = InvalidationTypes.refresh,
  });
}
