import '../../../../core/domain/entities/cache_entity.dart';
import '../../../../core/domain/enums/cache_type.dart';

final class FileCacheEntity extends CacheEntity {
  final String url;
  final String relativePath;

  const FileCacheEntity({
    required super.id,
    required super.metadata,
    required this.url,
    required this.relativePath,
  }) : super(cacheType: CacheType.file);

  String get fileName => url.split('/').last;
}
