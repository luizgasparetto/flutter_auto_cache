class GetCacheDTO {
  final String key;

  const GetCacheDTO({
    required this.key,
  });
}

class GetListCacheDTO<T extends Object> extends GetCacheDTO {
  const GetListCacheDTO({
    required super.key,
  });

  Type get dataType => T.runtimeType;
}
