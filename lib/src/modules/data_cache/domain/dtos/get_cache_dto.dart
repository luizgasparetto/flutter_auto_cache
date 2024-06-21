class GetCacheDTO {
  final String key;

  const GetCacheDTO({required this.key});
}

class GetListCacheDTO extends GetCacheDTO {
  final Type dataType;

  const GetListCacheDTO({
    required super.key,
    required this.dataType,
  });
}
