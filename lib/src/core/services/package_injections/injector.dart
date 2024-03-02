class Injector {
  Injector._();

  static final Injector _instance = Injector._();

  static Injector get instance => _instance;

  final _dependencies = <Type, dynamic>{};

  T get<T>() {
    return _dependencies[T] as T;
  }

  void bindSingleton<T>(Object instance) {
    _dependencies[T] = instance;
  }

  void bindFactory<T>(T Function() factory) {
    _dependencies[T] = factory();
  }

  Future<void> asyncBind<T>(Future<T> Function() factory) async {
    _dependencies[T] = await factory();
  }

  bool get hasBinds => _dependencies.isNotEmpty;
}
