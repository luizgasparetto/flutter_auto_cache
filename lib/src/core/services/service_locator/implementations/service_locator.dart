import 'package:flutter/foundation.dart';

import '../exceptions/service_locator_exceptions.dart';
import '../i_service_locator.dart';

/// Implementation of the [IServiceLocator] interface.
/// This class manages the lifecycle and retrieval of service instances.
final class ServiceLocator implements IServiceLocator {
  ServiceLocator._();

  /// Singleton instance of [ServiceLocator].
  static final ServiceLocator _instance = ServiceLocator._();

  /// Provides access to the singleton instance of the service locator.
  static ServiceLocator get instance => _instance;

  // Map to hold singleton service instances.
  final Map<Type, Object> _binds = {};

  // Map to hold factory functions for creating service instances.
  final Map<Type, Object Function()> _factoryBinds = {};

  /// Retrieves a service instance of type [T].
  /// If the service is not found, it tries to create it using the factory function if available.
  ///
  /// [T] - The type of the service to retrieve.
  ///
  /// Throws [BindNotFoundException] if the service is not registered.
  @override
  T get<T extends Object>() {
    final bind = _binds[T] ?? _factoryBinds[T]?.call();

    if (bind == null) {
      throw BindNotFoundException('Service of type $T is not registered.');
    }

    return bind as T;
  }

  /// Asynchronously binds a service instance of type [T].
  ///
  /// [T] - The type of the service being bound.
  /// [asyncBind] - A future that completes with the service instance to bind.
  @override
  Future<void> asyncBind<T extends Object>(Future<T> asyncBind) async {
    _binds[T] = await asyncBind;
  }

  /// Binds a singleton service instance of type [T].
  ///
  /// [T] - The type of the service being bound.
  /// [singletonBind] - The service instance to bind as a singleton.
  @override
  void bindSingleton<T extends Object>(T singletonBind) {
    _binds[T] = singletonBind;
  }

  /// Binds a factory function for creating service instances of type [T].
  ///
  /// [T] - The type of the service being bound.
  /// [factoryBind] - A function that creates and returns the service instance.
  @override
  void bindFactory<T extends Object>(T Function() factoryBind) {
    _factoryBinds[T] = factoryBind;
  }

  /// Resets all service bindings.
  @visibleForTesting
  void resetBinds() {
    _binds.clear();
    _factoryBinds.clear();
  }
}
