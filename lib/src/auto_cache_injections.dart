import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/core.dart';

import 'core/configuration/stores/cache_configuration_store.dart';

import 'core/services/cache_size_service/cache_size_service.dart';
import 'core/services/cryptography_service/implementations/encrypt_cryptography_service.dart';
import 'core/services/cryptography_service/i_cryptography_service.dart';
import 'core/services/cryptography_service/implementations/factories/encrypter_factory.dart';
import 'core/services/directory_service/directory_provider_service.dart';
import 'core/services/path_provider_service/i_path_provider_service.dart';
import 'core/services/kvs_service/i_kvs_service.dart';
import 'core/services/kvs_service/implementations/shared_preferences_kvs_service.dart';
import 'core/services/path_provider_service/implementations/path_provider_service.dart';
import 'core/services/service_locator/implementations/service_locator.dart';

import 'modules/data_cache/domain/repositories/i_data_cache_repository.dart';
import 'modules/data_cache/domain/services/invalidation_service/invalidation_cache_service.dart';
import 'modules/data_cache/domain/services/substitution_service/substitution_cache_service.dart';
import 'modules/data_cache/domain/usecases/clear_data_cache_usecase.dart';
import 'modules/data_cache/domain/usecases/delete_data_cache_usecase.dart';
import 'modules/data_cache/domain/usecases/get_data_cache_usecase.dart';
import 'modules/data_cache/domain/usecases/write_data_cache_usecase.dart';
import 'modules/data_cache/external/datasources/data_cache_datasource.dart';
import 'modules/data_cache/infra/datasources/i_data_cache_datasource.dart';
import 'modules/data_cache/infra/repositories/data_cache_repository.dart';

class AutoCacheInjections {
  static bool get isInjectorInitialized => ServiceLocator.instance.hasBinds;

  static Future<void> registerBinds() async {
    await _registerLibs();
    _registerCore();
    _registerDataCache();
  }

  static Future<void> _registerLibs() async {
    await ServiceLocator.instance.asyncBind(SharedPreferences.getInstance);
  }

  static void _registerCore() {
    ServiceLocator.instance.bindSingleton<CacheConfiguration>(CacheConfigurationStore.instance.config);
    ServiceLocator.instance.bindSingleton<Encrypter>(EncrypterFactory.createEncrypter(_get()));
    ServiceLocator.instance.bindSingleton<IPathProviderService>(PathProviderService());
    ServiceLocator.instance.bindFactory<ICacheSizeService>(() => CacheSizeService(_get(), _get()));
    ServiceLocator.instance.bindSingleton<IKvsService>(SharedPreferencesKvsService(_get()));
    ServiceLocator.instance.bindSingleton<ICryptographyService>(EncryptCryptographyService(_get(), _get()));
    ServiceLocator.instance.bindSingleton<IDirectoryProviderService>(DirectoryProviderService(_get()));
  }

  static void _registerDataCache() {
    ServiceLocator.instance.bindFactory<IDataCacheDatasource>(() => DataCacheDatasource(_get(), _get(), _get()));
    ServiceLocator.instance.bindFactory<IInvalidationCacheService>(() => InvalidationCacheService(_get()));
    ServiceLocator.instance.bindFactory<IDataCacheRepository>(() => DataCacheRepository(_get()));
    ServiceLocator.instance.bindFactory<ISubstitutionCacheService>(() => SubstitutionCacheService(_get(), _get()));
    ServiceLocator.instance.bindFactory<IDeleteDataCacheUsecase>(() => DeleteDataCacheUsecase(_get()));
    ServiceLocator.instance.bindFactory<IClearDataCacheUsecase>(() => ClearDataCacheUsecase(_get()));
    ServiceLocator.instance.bindFactory<IGetDataCacheUsecase>(() => GetDataCacheUsecase(_get(), _get()));
    ServiceLocator.instance.bindFactory<IWriteDataCacheUsecase>(() => WriteDataCacheUsecase(_get(), _get(), _get()));
  }

  static T _get<T extends Object>() => ServiceLocator.instance.get<T>();
}
