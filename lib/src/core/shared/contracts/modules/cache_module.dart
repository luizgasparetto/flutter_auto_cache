part of 'package_module.dart';

abstract class CacheModule {
  Future<void> registerBinds();

  T get<T extends Object>() => ServiceLocator.instance.get<T>();
}
