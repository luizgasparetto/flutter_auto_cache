import 'package:flutter/foundation.dart';

import '../exceptions/service_locator_exceptions.dart';
import '../i_service_locator.dart';

final class ServiceLocator implements IServiceLocator {
  ServiceLocator._();

  static final ServiceLocator _instance = ServiceLocator._();

  static ServiceLocator get instance => _instance;

  final Map<Type, Object> _binds = {};
  final Map<Type, Object Function()> _factoryBinds = {};

  @override
  bool get hasBinds => _binds.isNotEmpty || _factoryBinds.isNotEmpty;

  @override
  T get<T extends Object>() {
    final bind = _binds[T] ?? _factoryBinds[T]?.call();

    if (bind == null) {
      throw BindNotFoundException(message: 'Service of type $T is not registered.');
    }

    return bind as T;
  }

  @override
  Future<void> asyncBind<T extends Object>(Future<T> Function() bind) async {
    _binds[T] = await bind();
  }

  @override
  void bindSingleton<T extends Object>(T singletonBind) {
    _binds[T] = singletonBind;
  }

  @override
  void bindFactory<T extends Object>(T Function() factoryBind) {
    _factoryBinds[T] = factoryBind;
  }

  @visibleForTesting
  void resetBinds() {
    _binds.clear();
    _factoryBinds.clear();
  }
}
