abstract class AutoCacheManagerException implements Exception {
  final String message;

  ///[StackTrace] used to reference exception log
  final StackTrace stackTrace;

  ///[String] code of exception, used to match exception type without knowing error impl [class]
  final String code;

  ///Base constructor of [AutoCacheManagerException]
  const AutoCacheManagerException({
    required this.code,
    required this.message,
    StackTrace? stackTrace,
  }) : stackTrace = stackTrace ?? StackTrace.empty;
}
