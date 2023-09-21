abstract class CacheManagerException {
  final String message;
  final StackTrace stackTrace;
  final String errorCode;

  const CacheManagerException({
    required this.message,
    required this.stackTrace,
    required this.errorCode,
  });
}
