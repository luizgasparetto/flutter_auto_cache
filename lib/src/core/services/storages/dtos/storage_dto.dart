class StorageDTO<T extends Object> {
  final String id;
  final T data;
  final String invalidationTypeCode;
  final DateTime createdAt;

  const StorageDTO({
    required this.id,
    required this.data,
    required this.invalidationTypeCode,
    required this.createdAt,
  });
}
