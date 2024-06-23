import 'enums/cache_response_status.dart';

sealed class CacheResponse<T> {
  final T data;
  final String status;

  const CacheResponse({
    required this.data,
    required this.status,
  });
}

class SuccessCacheResponse<T extends Object> extends CacheResponse<T> {
  SuccessCacheResponse({required super.data}) : super(status: CacheResponseStatus.success.status);
}

class NotFoundCacheResponse extends CacheResponse<Null> {
  NotFoundCacheResponse() : super(data: null, status: CacheResponseStatus.notFound.status);
}

class ExpiredCacheResponse extends CacheResponse<Null> {
  ExpiredCacheResponse() : super(data: null, status: CacheResponseStatus.expired.status);
}
