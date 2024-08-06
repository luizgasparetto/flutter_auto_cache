import '../constants/token_request_constants.dart';

sealed class TokenBucketState {
  final int availableTokens;

  const TokenBucketState({required this.availableTokens});

  bool get isAvailable => availableTokens >= TokenRequestConstants.minAvailableCalls;

  //bool get isAvailable => this is AvailableTokenBucketState;
}

final class InitialTokenBucketState extends TokenBucketState {
  const InitialTokenBucketState._({required super.availableTokens});

  factory InitialTokenBucketState.create(calls) {
    return InitialTokenBucketState._(availableTokens: calls);
  }
}

final class NotAvailableTokenBucketState extends TokenBucketState {
  const NotAvailableTokenBucketState._({required super.availableTokens});

  factory NotAvailableTokenBucketState.create() {
    return const NotAvailableTokenBucketState._(availableTokens: 0);
  }
}

final class AvailableTokenBucketState extends TokenBucketState {
  const AvailableTokenBucketState._({required super.availableTokens});

  factory AvailableTokenBucketState.create({required int availableTokens}) {
    return AvailableTokenBucketState._(availableTokens: availableTokens);
  }
}
