import 'dart:async';

import '../../contracts/auto_cache_notifier.dart';
import 'constants/token_request_constants.dart';

import 'states/token_bucket_state.dart';

typedef _TokenBucketCallback = Future<void> Function();

/// Represents a controller for managing token bucket operations.
abstract interface class ITokenBucketController {
  /// Executes a callback function within the context of token bucket management.
  ///
  /// This method ensures that the callback is executed only when tokens are available.
  /// If tokens are not available, it waits until they become available before executing the callback.
  /// After execution, it updates the token count.
  ///
  /// [callback] is the function to be executed when tokens are available.
  ///
  /// Throws an exception if the execution fails or if token management encounters an error.
  Future<void> handle(_TokenBucketCallback callback);
}

class TokenBucketController extends AutoCacheNotifier<TokenBucketState> implements ITokenBucketController {
  TokenBucketController() : super(InitialTokenBucketState.create(TokenRequestConstants.maxCalls));

  @override
  Future<void> handle(_TokenBucketCallback callback) async {
    this._handleCallCount(value.availableTokens - 1);

    if (!value.isAvailable) await _getAvailable();

    await callback.call();

    this._handleCallCount(value.availableTokens + 1);
  }

  void _handleCallCount(int availableTokens) {
    if (availableTokens < TokenRequestConstants.minAvailableCalls) {
      return setData(NotAvailableTokenBucketState.create());
    }

    return setData(AvailableTokenBucketState.create(availableTokens: availableTokens));
  }

  Future<void> _getAvailable() async {
    final completer = Completer<void>();

    this.addListener(() => _listenerCompleter(completer));

    return completer.future;
  }

  void _listenerCompleter(Completer completer) {
    if (this.value.isAvailable && !completer.isCompleted) {
      this.removeListener(() => _listenerCompleter(completer));
      completer.complete();
    }
  }
}
