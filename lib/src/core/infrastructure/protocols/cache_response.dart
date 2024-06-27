import 'enums/cache_response_status.dart';
import 'value_objects/internal_cache_info.dart';

sealed class CacheResponse<T> {
  final T data;
  final InternalCacheInfo? info;
  final CacheResponseStatus status;

  const CacheResponse({
    required this.data,
    this.info,
    required this.status,
  });
}

class SuccessCacheResponse<T extends Object> extends CacheResponse<T> {
  SuccessCacheResponse({required super.data, required super.info}) : super(status: CacheResponseStatus.success);
}

class NotFoundCacheResponse extends CacheResponse<Null> {
  NotFoundCacheResponse() : super(data: null, status: CacheResponseStatus.notFound);
}

class ExpiredCacheResponse extends CacheResponse<Null> {
  ExpiredCacheResponse({required super.info}) : super(data: null, status: CacheResponseStatus.expired);
}
