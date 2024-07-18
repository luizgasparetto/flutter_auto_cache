import 'cache_module.dart';

abstract class PackageModule {
  List<CacheModule> modules = const [];

  Future<void> initialize() async {
    await Future.forEach(modules, (module) => module.registerBinds());
  }
}
