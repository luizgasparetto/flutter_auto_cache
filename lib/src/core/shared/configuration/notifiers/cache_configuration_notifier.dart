import '../../../../../flutter_auto_cache.dart';

import '../../contracts/auto_cache_notifier.dart';
import '../cache_configuration.dart';

final class CacheConfigurationNotifier extends AutoCacheNotifier<CacheConfiguration> {
  CacheConfigurationNotifier._() : super(CacheConfiguration.defaultConfig());

  static final _instance = CacheConfigurationNotifier._();
  static CacheConfigurationNotifier get instance => _instance;

  final memento = _MementoCacheConfigurationNotifier();

  CacheConfiguration get config => value;

  void setDataOptions(DataCacheOptions? options) => value.setDataOptions(options ?? memento.dataOptions);

  void setConfiguration(CacheConfiguration? config) {
    value = config ?? value;
    memento.setMemento(value);
  }
}

final class _MementoCacheConfigurationNotifier extends AutoCacheNotifier<CacheConfiguration> {
  _MementoCacheConfigurationNotifier() : super(CacheConfiguration.defaultConfig());

  DataCacheOptions get dataOptions => value.dataCacheOptions;

  void setMemento(CacheConfiguration memento) => value = memento;
}
