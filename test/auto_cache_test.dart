import 'package:flutter_auto_cache/flutter_auto_cache.dart';
import 'package:flutter_auto_cache/src/core/infrastructure/middlewares/exceptions/initializer_exceptions.dart';
import 'package:flutter_auto_cache/src/core/services/service_locator/implementations/service_locator.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/presenter/controllers/implementations/base_data_cache_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() {
    ServiceLocator.instance.resetBinds();
  });

  group('AutoCache |', () {
    test('should be able to throw a NotInitializedAutoCacheManagerException when NOT initialize AutoCache', () {
      expect(() => AutoCache.data, throwsA(isA<NotInitializedAutoCacheException>()));
    });

    test('should be able to verify instances and binds of cache controllers', () async {
      await AutoCacheInitializer.initialize();

      expect(AutoCache.data, equals(DataCacheController.instance));
    });
  });
}
