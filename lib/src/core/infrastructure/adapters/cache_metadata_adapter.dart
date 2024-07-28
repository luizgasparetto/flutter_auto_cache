import '../../domain/value_objects/cache_metadata.dart';

final class CacheMetadataAdapter {
  static CacheMetadata fromJson(Map<String, dynamic> json) {
    return CacheMetadata(
      createdAt: DateTime.parse(json['created_at']),
      endAt: DateTime.parse(json['end_at']),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
      usedAt: DateTime.tryParse(json['used_at'] ?? ''),
    );
  }

  static Map<String, dynamic> toJson(CacheMetadata metadata) {
    return {
      'created_at': metadata.createdAt.toIso8601String(),
      'end_at': metadata.endAt.toIso8601String(),
      'updated_at': metadata.updatedAt?.toIso8601String(),
      'used_at': metadata.usedAt?.toIso8601String(),
    };
  }
}
