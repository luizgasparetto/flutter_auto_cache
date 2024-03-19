import '../../../../core.dart';

class CacheSizeAnalyzerException extends AutoCacheManagerException {
  CacheSizeAnalyzerException({
    required super.code,
    required super.message,
    required super.stackTrace,
  });
}

class CalculateCacheSizeException extends AutoCacheManagerException {
  CalculateCacheSizeException({
    required super.code,
    required super.message,
    required super.stackTrace,
  });
}
