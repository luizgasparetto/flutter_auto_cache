import 'package:flutter_test/flutter_test.dart';

import '../commons/extensions/fake_async_extensions.dart';
import '../commons/helpers/integration_test_helpers.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  final sut = await initializePrefsController();

  group('GetCacheIntegrationTest.getString |', () {
    integrationTest('should be able to call getString and return NULL when doesnt have cache', (fakeAsync) {
      final response = fakeAsync.integrationAsync(() => sut.getString(key: 'string_key'));

      expect(response, isNull);
    });

    integrationTest('should be able to call getString and return DATA when have cache', (fakeAsync) {
      fakeAsync.integrationAsync(() => sut.saveString(key: 'string_key', data: 'custom_data'));

      final response = fakeAsync.integrationAsync(() => sut.getString(key: 'string_key'));

      expect(response, equals('custom_data'));
    });
  });

  group('GetCacheIntegrationTest.getInt |', () {
    integrationTest('should be able to call getInt and return NULL when doesnt have cache', (fakeAsync) {
      final response = fakeAsync.integrationAsync(() => sut.getInt(key: 'int_key'));

      expect(response, isNull);
    });

    integrationTest('should be able to call getInt and return DATA when have cache', (fakeAsync) {
      fakeAsync.integrationAsync(() => sut.saveInt(key: 'int_key', data: 1));

      final response = fakeAsync.integrationAsync(() => sut.getInt(key: 'int_key'));

      expect(response, equals(1));
    });
  });

  group('GetCacheIntegrationTest.getJson |', () {
    final json = {'key': 'key_value'};

    integrationTest('should be able to call getDouble and return NULL when doesnt have cache', (fakeAsync) {
      final response = fakeAsync.integrationAsync(() => sut.getJson(key: 'json_key'));

      expect(response, isNull);
    });

    integrationTest('should be able to call getInt and return DATA when have cache', (fakeAsync) {
      fakeAsync.integrationAsync(() => sut.saveJson(key: 'json_key', data: json));

      final response = fakeAsync.integrationAsync(() => sut.getJson(key: 'json_key'));

      expect(response, equals(json));
    });
  });

  group('GetCacheIntegrationTest.getList |', () {
    final list = List.generate(5, (_) => {'key': 'key_value'});

    integrationTest('should be able to call getList of T and return NULL when doesnt have cache', (fakeAsync) {
      final response = fakeAsync.integrationAsync(() => sut.getList<Map<String, dynamic>>(key: 'list_key'));

      expect(response, isNull);
    });

    integrationTest('should be able to call getList of T and return DATA when have cache', (fakeAsync) {
      fakeAsync.integrationAsync(() => sut.saveList<Map<String, dynamic>>(key: 'list_key', data: list));

      final response = fakeAsync.integrationAsync(() => sut.getList<Map<String, dynamic>>(key: 'list_key'));

      expect(response, equals(list));
    }, skip: true);
  });
}
