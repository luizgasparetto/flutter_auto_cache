import 'cache_module.dart';

abstract class PackageModule {
  List<CacheModule> modules = const [];

  Future<void> initialize() async {
    for (int i = 0; i < modules.length; i++) {
      await modules[i].registerBinds();
    }
  }
}
