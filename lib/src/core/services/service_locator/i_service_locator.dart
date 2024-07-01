/// An interface for the service locator pattern, defining methods for binding
/// and retrieving services.
abstract interface class IServiceLocator {
  /// Retrieves a service instance.
  ///
  /// [T] - The type of the service to retrieve.
  ///
  /// Throws [BindNotFoundException] if the service is not registered.
  T get<T extends Object>();

  /// Asynchronously binds a service instance.
  ///
  /// [T] - The type of the service being bound.
  /// [bind] - A future that completes with the service instance to bind.
  Future<void> asyncBind<T extends Object>(Future<T> Function() bind);

  /// Binds a singleton service instance.
  ///
  /// [T] - The type of the service being bound.
  /// [bind] - The service instance to bind as a singleton.
  void bindSingleton<T extends Object>(T bind);

  /// Binds a factory function for creating service instances.
  ///
  /// [T] - The type of the service being bound.
  /// [factoryBind] - A function that creates and returns the service instance.
  void bindFactory<T extends Object>(T Function() factoryBind);

  bool get hasBinds;
}
