import '../../services/service_locator/implementations/service_locator.dart';

typedef GetBindCallback = T Function<T>();

abstract class CacheModule {
  Future<void> registerBinds();

  T get<T extends Object>() => ServiceLocator.instance.get<T>();
}
