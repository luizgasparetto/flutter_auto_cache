import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'infrastructure/contracts/module_contracts.dart';
import 'shared/configuration/cache_configuration.dart';
import 'shared/configuration/stores/cache_configuration_store.dart';
import 'shared/services/cache_size_service/cache_size_service.dart';
import 'shared/services/cryptography_service/i_cryptography_service.dart';
import 'shared/services/cryptography_service/implementations/encrypt_cryptography_service.dart';
import 'shared/services/cryptography_service/implementations/factories/encrypter_factory.dart';
import 'shared/services/directory_service/directory_provider_service.dart';
import 'shared/services/kvs_service/i_kvs_service.dart';
import 'shared/services/kvs_service/implementations/shared_preferences_kvs_service.dart';
import 'shared/services/path_provider_service/i_path_provider_service.dart';
import 'shared/services/path_provider_service/implementations/path_provider_service.dart';
import 'shared/services/service_locator/implementations/service_locator.dart';

class CoreModule extends CacheModule {
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
