import 'core/core.dart';

class AutoCacheManagerInitialazer {
  AutoCacheManagerInitialazer._();

  static final AutoCacheManagerInitialazer _instance = AutoCacheManagerInitialazer._();

  static AutoCacheManagerInitialazer get instance => _instance;

  Future<void> init() async {
    await PackageInjections.registerBinds();
  }

  bool get isInitialized => Injector.instance.hasBinds;
}
