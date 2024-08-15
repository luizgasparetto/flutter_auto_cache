import '../../../../core/domain/entities/cache_entity.dart';
import '../../../../core/domain/enums/cache_type.dart';

import '../value_objects/url_details.dart';

final class FileCacheEntity extends CacheEntity<String?> {
  final UrlDetails url;
  final String relativePath;

  const FileCacheEntity({
    required super.id,
    required super.metadata,
    required this.url,
    required this.relativePath,
  }) : super(cacheType: CacheType.file);

  String get key => super.id ?? url.value;
}
