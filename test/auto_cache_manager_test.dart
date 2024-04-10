import 'package:auto_cache_manager/auto_cache_manager.dart';
import 'package:auto_cache_manager/src/modules/data_cache/presenter/controllers/base_cache_manager_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('AutoCacheManager |', () {
    test('should be able to verify instances and binds of cache controllers',
        () async {
      await AutoCacheManagerInitializer.I.init();

      expect(
          AutoCacheManager.prefs, equals(PrefsCacheManagerController.instance));
      expect(AutoCacheManager.sql, equals(SQLCacheManagerController.instance));
    });
  });
}
