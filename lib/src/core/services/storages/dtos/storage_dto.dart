class StorageDTO<T extends Object> {
  final String id;
  final T data;
  final String invalidationTypeCode;
  final DateTime createdAt;
  final DateTime endAt;

  const StorageDTO({
    required this.id,
    required this.data,
    required this.invalidationTypeCode,
    required this.createdAt,
    required this.endAt,
  });
}
