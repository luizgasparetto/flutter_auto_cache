import 'package:flutter_test/flutter_test.dart';

import '../../../commons/helpers/integration_test_helpers.dart';

Future<void> main() async {
  final sut = await initializePrefsController();

  group('SaveCacheIntegrationTest.saveString |', () {
    test('should be able to save a string in prefs cache and completes operation', () async {
      await expectLater(sut.saveString(key: 'string_key', data: 'string_data'), completes);
    });

    test('should be able to save a string in prefs cache and verify values', () async {
      await sut.saveString(key: 'string_key', data: 'string_data');

      final response = await sut.getString(key: 'string_key');

      expect(response, isNotNull);
      expect(response, equals('string_data'));
    });
  });

  group('SaveCacheIntegrationTest.saveInt |', () {
    test('should be able to save an int in prefs cache and completes operation', () async {
      await expectLater(sut.saveInt(key: 'int_key', data: 1), completes);
    });

    test('should be able to save an int in prefs cache and verify values', () async {
      await sut.saveInt(key: 'int_key', data: 1);

      final response = await sut.getInt(key: 'int_key');

      expect(response, isNotNull);
      expect(response, equals(1));
    });
  });

  group('SaveCacheIntegrationTest.saveJson |', () {
    final simpleJson = {'key': 'value'};

    final complexJson = {
      ...simpleJson,
      'list': ['value_1', 'value_2']
    };

    test('should be able to save a simple JSON in prefs cache and completes operation', () async {
      await expectLater(sut.saveJson(key: 'json_key', data: simpleJson), completes);
    });

    test('should be able to save a complex JSON in prefs cache and completes operation', () async {
      await expectLater(sut.saveJson(key: 'complex_json_key', data: complexJson), completes);
    });

    test('should be able to save a simple JSON in prefs cache and verify values', () async {
      await sut.saveJson(key: 'json_key', data: simpleJson);

      final response = await sut.getJson(key: 'json_key');

      expect(response, isNotNull);
      expect(response, equals(simpleJson));
    });

    test('should be able to save a complex JSON in prefs cache and verify values', () async {
      await sut.saveJson(key: 'complex_json_key', data: complexJson);

      final response = await sut.getJson(key: 'complex_json_key');

      expect(response, isNotNull);
      expect(response, equals(complexJson));
    });
  });

  group('SaveCacheIntegrationTest.saveList |', () {
    final stringList = ['value_1', 'value_2', 'value_3'];

    test('should be able to save a list of string in prefs cache and completes operation', () async {
      await expectLater(sut.saveList(key: 'string_list_key', data: stringList), completes);
    });
  });
}
