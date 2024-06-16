import '../../../../core/core.dart';

class GetCacheSizeFailure extends AutoCacheFailure {
  const GetCacheSizeFailure({required super.message}) : super(code: 'get_cache_size');
}

class CalculateCacheSizeFailure extends AutoCacheFailure {
  const CalculateCacheSizeFailure({required super.message}) : super(code: 'calculate_cache_size');
}
