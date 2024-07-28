import '../../errors/auto_cache_error.dart';

/// An interface for logging services.
///
/// This interface defines the contract for logging services
/// that handle the logging of errors in the auto cache system.
abstract interface class ILogService {
  /// Logs an error.
  ///
  /// This method is responsible for logging an [AutoCacheError].
  void logError(AutoCacheError error);
}
