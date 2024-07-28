import '../../domain/value_objects/cache_metadata.dart';

import 'enums/cache_response_status.dart';

sealed class CacheResponse<T> {
  final T data;
  final CacheResponseStatus status;
  final CacheMetadata? metadata;

  const CacheResponse({required this.data, required this.status, this.metadata});
}

class SuccessCacheResponse<T extends Object> extends CacheResponse<T> {
  SuccessCacheResponse({required super.data, required super.metadata}) : super(status: CacheResponseStatus.success);
}

class NotFoundCacheResponse extends CacheResponse<Null> {
  NotFoundCacheResponse() : super(data: null, status: CacheResponseStatus.notFound);
}

class ExpiredCacheResponse extends CacheResponse<Null> {
  ExpiredCacheResponse({required super.metadata}) : super(data: null, status: CacheResponseStatus.expired);
}
