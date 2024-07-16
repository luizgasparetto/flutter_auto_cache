import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'configuration/cache_configuration.dart';
import 'configuration/stores/cache_configuration_store.dart';
import 'infrastructure/modules/cache_module.dart';
import 'services/cache_size_service/cache_size_service.dart';
import 'services/cryptography_service/i_cryptography_service.dart';
import 'services/cryptography_service/implementations/encrypt_cryptography_service.dart';
import 'services/cryptography_service/implementations/factories/encrypter_factory.dart';
import 'services/directory_service/directory_provider_service.dart';
import 'services/kvs_service/i_kvs_service.dart';
import 'services/kvs_service/implementations/shared_preferences_kvs_service.dart';
import 'services/path_provider_service/i_path_provider_service.dart';
import 'services/path_provider_service/implementations/path_provider_service.dart';
import 'services/service_locator/implementations/service_locator.dart';

export 'configuration/cache_configuration.dart';
export 'services/cryptography_service/value_objects/cache_cryptography_options.dart';
export 'services/cache_size_service/value_objects/cache_size_options.dart';
export 'errors/auto_cache_error.dart';

class CoreModule extends CacheModule {
  CoreModule._();

  static final CoreModule _instance = CoreModule._();

  static CoreModule get instance => _instance;

  @override
  Future<void> registerBinds() async {
    await ServiceLocator.instance.asyncBind(SharedPreferences.getInstance);
    ServiceLocator.instance.bindSingleton<CacheConfiguration>(CacheConfigurationStore.instance.config);
    ServiceLocator.instance.bindSingleton<Encrypter>(EncrypterFactory.createEncrypter(get()));
    ServiceLocator.instance.bindFactory<IPathProviderService>(() => PathProviderService());
    ServiceLocator.instance.bindFactory<ICacheSizeService>(() => CacheSizeService(get(), get()));
    ServiceLocator.instance.bindFactory<IKvsService>(() => SharedPreferencesKvsService(get()));
    ServiceLocator.instance.bindFactory<ICryptographyService>(() => EncryptCryptographyService(get(), get()));
    ServiceLocator.instance.bindSingleton<IDirectoryProviderService>(DirectoryProviderService(get()));
  }
}
