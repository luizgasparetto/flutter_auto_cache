// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:meta/meta.dart';

import '../../shared/errors/auto_cache_error.dart';
import '../../shared/functional/either.dart';
import '../../shared/functional/equals.dart';
import '../failures/cache_time_details_failure.dart';

@immutable
final class CacheMetadata extends Equals {
  final DateTime createdAt;
  final DateTime endAt;
  final DateTime? updatedAt;
  final DateTime? usedAt;

  const CacheMetadata({
    required this.createdAt,
    required this.endAt,
    this.updatedAt,
    this.usedAt,
  });

  factory CacheMetadata.createDefault() {
    return CacheMetadata(createdAt: DateTime.now(), endAt: DateTime.now());
  }

  factory CacheMetadata.save({required DateTime endAt}) {
    return CacheMetadata(createdAt: DateTime.now(), endAt: endAt);
  }

  CacheMetadata update({required DateTime endAt}) {
    return copyWith(updatedAt: DateTime.now(), endAt: endAt);
  }

  CacheMetadata used() => copyWith(usedAt: DateTime.now());

  Either<AutoCacheError, Unit> validate() {
    if (endAt.isBefore(createdAt)) return left(EndBeforeCreatedAtFailure());
    if (updatedAt?.isBefore(createdAt) ?? false) return left(UpdatedBeforeCreatedAtFailure());
    if (usedAt?.isBefore(createdAt) ?? false) return left(UsedBeforeCreatedAtFailure());

    return right(unit);
  }

  @override
  List<Object?> get props => [createdAt, updatedAt, endAt, usedAt];

  CacheMetadata copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? endAt,
    DateTime? usedAt,
  }) {
    return CacheMetadata(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      endAt: endAt ?? this.endAt,
      usedAt: usedAt ?? this.usedAt,
    );
  }
}
