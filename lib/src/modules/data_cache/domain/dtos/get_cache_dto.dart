import '../enums/storage_type.dart';

class GetCacheDTO {
  final String key;
  final StorageType storageType;

  const GetCacheDTO({
    required this.key,
    required this.storageType,
  });
}

class GetListCacheDTO<T extends Object> extends GetCacheDTO {
  const GetListCacheDTO({
    required super.key,
    required super.storageType,
  });

  Type get dataType => T.runtimeType;
}
