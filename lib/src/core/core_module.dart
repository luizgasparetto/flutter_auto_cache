import 'dart:io';

import 'package:encrypt/encrypt.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'domain/services/invalidation_service/invalidation_cache_service.dart';
import 'shared/configuration/cache_configuration.dart';
import 'shared/configuration/notifiers/cache_configuration_notifier.dart';
import 'shared/contracts/modules/package_module.dart';
import 'shared/services/cache_size_service/cache_size_service.dart';
import 'shared/services/cryptography_service/i_cryptography_service.dart';
import 'shared/services/cryptography_service/implementations/encrypt_cryptography_service.dart';
import 'shared/services/cryptography_service/implementations/factories/encrypter_factory.dart';
import 'shared/services/directory_service/directory_provider_service.dart';
import 'shared/services/http_service/http_service.dart';
import 'shared/services/kvs_service/i_kvs_service.dart';
import 'shared/services/kvs_service/implementations/shared_preferences_kvs_service.dart';
import 'shared/services/path_provider_service/i_path_provider_service.dart';
import 'shared/services/path_provider_service/implementations/path_provider_service.dart';
import 'shared/services/service_locator/implementations/service_locator.dart';

export 'shared/configuration/cache_configuration.dart' hide PrivateGettersCacheConfiguration, PrivateSettersCacheConfiguration;
export 'domain/value_objects/invalidation_methods/invalidation_method.dart';

class CoreModule extends CacheModule {
  @override
  Future<void> registerBinds() async {
    await ServiceLocator.instance.asyncBind(SharedPreferences.getInstance);
    ServiceLocator.instance.bindSingleton<CacheConfiguration>(CacheConfigurationNotifier.instance.config);
    ServiceLocator.instance.bindSingleton<Encrypter>(EncrypterFactory.createEncrypter(get()));
    ServiceLocator.instance.bindFactory(() => HttpClient());
    ServiceLocator.instance.bindFactory<IHttpService>(() => HttpService(get()));
    ServiceLocator.instance.bindFactory<IPathProviderService>(() => PathProviderService());
    ServiceLocator.instance.bindFactory<ICacheSizeService>(() => CacheSizeService(get(), get()));
    ServiceLocator.instance.bindFactory<IKvsService>(() => SharedPreferencesKvsService(get()));
    ServiceLocator.instance.bindFactory<ICryptographyService>(() => EncryptCryptographyService(get(), get()));
    ServiceLocator.instance.bindSingleton<IDirectoryProviderService>(DirectoryProviderService(get()));
    ServiceLocator.instance.bindFactory<IInvalidationCacheService>(() => InvalidationCacheService(get()));
  }
}
