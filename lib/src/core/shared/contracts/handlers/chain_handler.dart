// ignore_for_file: unnecessary_getters_setters

import 'dart:async';

import '../../errors/auto_cache_error.dart';
import '../../functional/either.dart';

part 'internals/sync_chain_handler.dart';
part 'internals/async_chain_handler.dart';

sealed class ChainHandler<ReturnType extends FutureOr<Either>, Value extends Object> {
  ChainHandler? _nextHandler;

  ChainHandler? get nextHandler => _nextHandler;

  set nextHandler(ChainHandler? handler) => _nextHandler = handler;

  void setNext(ChainHandler handler) => nextHandler = handler;

  ReturnType handle(Value value);
}
