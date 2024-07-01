import 'package:flutter_test/flutter_test.dart';

import '../../../commons/helpers/integration_test_helpers.dart';

Future<void> main() async {
  final sut = await initializePrefsController();

  tearDown(() {
    sut.clear();
  });

  group('GetCacheIntegrationTest.getString |', () {
    test('should be able to call getString and return NULL when doesnt have cache', () async {
      final response = await sut.getString(key: 'string_key');

      expect(response, isNull);
    });

    test('should be able to call getString and return DATA when have cache', () async {
      await sut.saveString(key: 'string_key', data: 'custom_data');

      final response = await sut.getString(key: 'string_key');

      expect(response, equals('custom_data'));
    });
  });

  group('GetCacheIntegrationTest.getInt |', () {
    test('should be able to call getInt and return NULL when doesnt have cache', () async {
      final response = await sut.getInt(key: 'int_key');

      expect(response, isNull);
    });

    test('should be able to call getInt and return DATA when have cache', () async {
      await sut.saveInt(key: 'int_key', data: 1);

      final response = await sut.getInt(key: 'int_key');

      expect(response, equals(1));
    });
  });

  group('GetCacheIntegrationTest.getJson |', () {
    final json = {'key': 'key_value'};

    test('should be able to call getDouble and return NULL when doesnt have cache', () async {
      final response = await sut.getJson(key: 'json_key');

      expect(response, isNull);
    });

    test('should be able to call getInt and return DATA when have cache', () async {
      await sut.saveJson(key: 'json_key', data: json);

      final response = await sut.getJson(key: 'json_key');

      expect(response, equals(json));
    });
  });
}
