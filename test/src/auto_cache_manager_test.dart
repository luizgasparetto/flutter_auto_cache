import 'package:auto_cache_manager/src/auto_cache_manager.dart';
import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/usecases/get_cache_usecase.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/usecases/save_cache_usecase.dart';
import 'package:auto_cache_manager/src/modules/cache/presenter/controllers/base_cache_manager_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetCacheUsecaseMock extends Mock implements GetCacheUsecase {}

class SaveCacheUsecaseMock extends Mock implements SaveCacheUsecase {}

void main() {
  final getCacheUsecaseMock = GetCacheUsecaseMock();
  final saveCacheUsecase = SaveCacheUsecaseMock();

  setUpAll(() {
    Injector.I.bindSingleton<GetCacheUsecase>(getCacheUsecaseMock);
    Injector.I.bindSingleton<SaveCacheUsecase>(saveCacheUsecase);
  });

  tearDownAll(() {
    Injector.I.clear();
  });

  group('AutoCacheManager |', () {
    test('should be able to get a singleton of SQL controller', () {
      final sqlInstance = SQLCacheManagerController.instance;

      expect(AutoCacheManager.sql, equals(sqlInstance));
    });

    test('should be able to get a singleton of KVS controller', () {
      final kvsInstance = KVSCacheManagerController.instance;

      expect(AutoCacheManager.kvs, equals(kvsInstance));
    });
  });
}
