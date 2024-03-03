class Injector {
  Injector._();

  static final Injector _instance = Injector._();

  static Injector get instance => _instance;

  final _dependencies = <Type, Object>{};

  bool get hasBinds => _dependencies.isNotEmpty;

  T get<T>() {
    return _dependencies[T] as T;
  }

  void bindSingleton<T extends Object>(Object instance) {
    _dependencies[T] = instance;
  }

  void bindFactory<T extends Object>(Object Function() factory) {
    _dependencies[T] = factory();
  }

  Future<void> asyncBind<T extends Object>(Future<T> Function() factory) async {
    _dependencies[T] = await factory();
  }
}
