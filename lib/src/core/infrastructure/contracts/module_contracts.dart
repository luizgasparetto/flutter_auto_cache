import '../../shared/services/service_locator/implementations/service_locator.dart';

abstract class PackageModule {
  List<CacheModule> modules = const [];

  Future<void> initialize() async {
    await Future.forEach(modules, (module) => module.registerBinds());
  }
}

abstract class CacheModule {
  Future<void> registerBinds();

  T get<T extends Object>() => ServiceLocator.instance.get<T>();
}
