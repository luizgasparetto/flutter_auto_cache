import '../../auto_cache_injections.dart';

import '../exceptions/initializer_exceptions.dart';

class InitMiddleware {
  static T accessInstance<T extends Object>(T onSuccess) {
    InitMiddleware._initializedConfigVerification();
    return onSuccess;
  }

  static void _initializedConfigVerification() {
    final isInitialized = AutoCacheInjections.isInjectorInitialized;

    if (!isInitialized) {
      throw NotInitializedAutoCacheManagerException(
        message: 'Auto cache manager is not initialized.',
        stackTrace: StackTrace.current,
      );
    }
  }
}
