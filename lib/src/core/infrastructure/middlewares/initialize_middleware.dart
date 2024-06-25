import '../../../auto_cache_injections.dart';

import 'exceptions/initializer_exceptions.dart';

/// A class to handle initialization and configuration verifications.
class InitializeMiddleware {
  /// Returns an instance of type [T] after performing the initialization checks.
  ///
  /// The method uses a generic type [T] which ensures that it can handle any object type.
  /// It first performs a verification of initialization and if successful, returns the [onSuccess] instance.
  static T accessInstance<T extends Object>(T Function() onSuccess) {
    InitializeMiddleware._initializedConfigVerification();
    return onSuccess.call();
  }

  /// A private method to verify if the Auto Cache Injections are properly initialized.
  ///
  /// This method checks if the auto cache manager is initialized.
  /// If not, it throws a [NotInitializedAutoCacheException] with a message and the current stack trace.
  static void _initializedConfigVerification() {
    final isInitialized = AutoCacheInjections.instance.isInjectorInitialized;

    if (!isInitialized) {
      throw NotInitializedAutoCacheException(
        message: 'Auto cache manager is not initialized.',
        stackTrace: StackTrace.current,
      );
    }
  }
}
