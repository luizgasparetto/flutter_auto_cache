import '../../core/infrastructure/modules/cache_module.dart';
import '../../core/services/service_locator/implementations/service_locator.dart';

import 'domain/repositories/i_data_cache_repository.dart';
import 'domain/services/invalidation_service/invalidation_cache_service.dart';
import 'domain/services/substitution_service/substitution_cache_service.dart';
import 'domain/usecases/clear_data_cache_usecase.dart';
import 'domain/usecases/delete_data_cache_usecase.dart';
import 'domain/usecases/get_data_cache_usecase.dart';
import 'domain/usecases/write_data_cache_usecase.dart';

import 'external/datasources/command_data_cache_datasource.dart';
import 'external/datasources/query_data_cache_datasource.dart';

import 'infra/datasources/i_command_data_cache_datasource.dart';
import 'infra/datasources/i_query_data_cache_datasource.dart';
import 'infra/repositories/data_cache_repository.dart';

export 'presenter/controllers/implementations/base_data_cache_controller.dart' show IDataCacheController;
export 'domain/value_objects/data_cache_options.dart';
export 'domain/enums/substitution_policies.dart';
export 'domain/value_objects/invalidation_methods/invalidation_method.dart';

class DataCacheModule extends CacheModule {
  DataCacheModule._();

  static final DataCacheModule _instance = DataCacheModule._();

  static DataCacheModule get instance => _instance;

  @override
  Future<void> registerBinds() async {
    ServiceLocator.instance.bindFactory<IQueryDataCacheDatasource>(() => QueryDataCacheDatasource(get(), get(), get()));
    ServiceLocator.instance.bindFactory<ICommandDataCacheDatasource>(() => CommandDataCacheDatasource(get(), get()));
    ServiceLocator.instance.bindFactory<IInvalidationCacheService>(() => InvalidationCacheService(get()));
    ServiceLocator.instance.bindFactory<IDataCacheRepository>(() => DataCacheRepository(get(), get()));
    ServiceLocator.instance.bindFactory<ISubstitutionCacheService>(() => SubstitutionCacheService(get(), get()));
    ServiceLocator.instance.bindFactory<IDeleteDataCacheUsecase>(() => DeleteDataCacheUsecase(get()));
    ServiceLocator.instance.bindFactory<IClearDataCacheUsecase>(() => ClearDataCacheUsecase(get()));
    ServiceLocator.instance.bindFactory<IGetDataCacheUsecase>(() => GetDataCacheUsecase(get(), get()));
    ServiceLocator.instance.bindFactory<IWriteDataCacheUsecase>(() => WriteDataCacheUsecase(get(), get(), get()));
  }
}
