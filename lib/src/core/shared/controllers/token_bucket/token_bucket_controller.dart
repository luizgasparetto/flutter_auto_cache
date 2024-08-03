import 'dart:async';

import '../../constants/token_request_constants.dart';
import '../../contracts/auto_cache_notifier.dart';

import 'states/token_bucket_state.dart';

typedef _TokenBucketCallback = Future<void> Function();

abstract interface class ITokenBucketController {
  Future<void> execute(_TokenBucketCallback callback);
}

class TokenBucketController extends AutoCacheNotifier<TokenBucketState> implements ITokenBucketController {
  TokenBucketController() : super(InitialTokenBucketState.create(TokenRequestConstants.maxCalls));

  @override
  Future<void> execute(_TokenBucketCallback callback) async {
    this._handleCallCount();

    if (!value.isAvailable) await _getAvailable();

    await callback.call();

    this._handleCallCount();
  }

  void _handleCallCount() {
    final previousTokens = this.value.availableTokens - 1;

    if (!value.isAvailable) return;
    if (previousTokens >= TokenRequestConstants.minAvailableCalls) setData(NotAvailableTokenBucketState.create());

    setData(AvailableTokenBucketState.create(availableTokens: previousTokens));
  }

  Future<void> _getAvailable() async {
    final completer = Completer();

    this.addListener(() => _listenerCompleter(completer));

    await completer.future;

    this.removeListener(() => _listenerCompleter(completer));
  }

  void _listenerCompleter(Completer completer) {
    if (this.value.isAvailable && !completer.isCompleted) completer.complete();
  }
}
