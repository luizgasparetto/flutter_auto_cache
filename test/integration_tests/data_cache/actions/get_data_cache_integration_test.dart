import 'package:flutter_auto_cache/flutter_auto_cache.dart';
import 'package:flutter_auto_cache/src/core/infrastructure/protocols/enums/cache_response_status.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../commons/helpers/integration_test_helpers.dart';

Future<void> main() async {
  const dataCacheOptions = DataCacheOptions(invalidationMethod: TTLInvalidationMethod(maxDuration: Duration(milliseconds: 100)));
  const config = CacheConfiguration(dataCacheOptions: dataCacheOptions);

  final sut = await initializeDataController(config: config);

  tearDown(() {
    sut.clear();
  });

  group('GetDataCacheIntegrationTest.getString |', () {
    test('should be able to call getString and return DATA when have cache', () async {
      await sut.saveString(key: 'first_string_key', data: 'custom_data');

      final response = await sut.getString(key: 'first_string_key');

      expect(response.data, equals('custom_data'));
      expect(response.status, equals(CacheResponseStatus.success));
    });

    test('should be able to call getString and return NULL when doesnt have cache', () async {
      final response = await sut.getString(key: 'string_key');

      expect(response.data, isNull);
      expect(response.status, equals(CacheResponseStatus.notFound));
    });

    test('should be able to call getString and return NULL when cache is expired', () async {
      await sut.saveString(key: 'string_key', data: 'custom_data');
      await Future.delayed(const Duration(milliseconds: 100));

      final response = await sut.getString(key: 'string_key');

      expect(response.data, isNull);
      expect(response.status, equals(CacheResponseStatus.expired));
    });
  });

  group('GetDataCacheIntegrationTest.getInt |', () {
    test('should be able to call getInt and return DATA when have cache', () async {
      await sut.saveInt(key: 'int_key', data: 1);

      final response = await sut.getInt(key: 'int_key');

      expect(response.data, equals(1));
      expect(response.status, equals(CacheResponseStatus.success));
    });

    test('should be able to call getInt and return NULL when doesnt have cache', () async {
      final response = await sut.getInt(key: 'int_key');

      expect(response.data, isNull);
      expect(response.status, equals(CacheResponseStatus.notFound));
    });

    test('should be able to call getInt and return NULL when cache is expired', () async {
      await sut.saveInt(key: 'int_key', data: 1);
      await Future.delayed(const Duration(milliseconds: 100));

      final response = await sut.getInt(key: 'int_key');

      expect(response.data, isNull);
      expect(response.status, equals(CacheResponseStatus.expired));
    });
  });

  group('GetDataCacheIntegrationTest.getJson |', () {
    final json = {'key': 'key_value'};

    test('should be able to call getJson and return DATA when have cache', () async {
      await sut.saveJson(key: 'json_key', data: json);

      final response = await sut.getJson(key: 'json_key');

      expect(response.data, equals(json));
      expect(response.status, equals(CacheResponseStatus.success));
    });

    test('should be able to call getJson and return NULL when doesnt have cache', () async {
      final response = await sut.getJson(key: 'json_key');

      expect(response.data, isNull);
      expect(response.status, equals(CacheResponseStatus.notFound));
    });

    test('should be able to call getJson and return NULL when cache is expired', () async {
      await sut.saveJson(key: 'json_key', data: json);
      await Future.delayed(const Duration(milliseconds: 100));

      final response = await sut.getJson(key: 'json_key');

      expect(response.data, isNull);
      expect(response.status, equals(CacheResponseStatus.expired));
    });
  });

  group('GetDataCacheIntegrationTest.getStringList |', () {
    final data = ['data', 'data'];

    test('should be able to call getStringList and return DATA when have cache', () async {
      await sut.saveStringList(key: 'string_list_key', data: data);

      final response = await sut.getStringList(key: 'string_list_key');

      expect(response.data, equals(data));
      expect(response.status, equals(CacheResponseStatus.success));
    });

    test('should be able to call getStringList and return NULL when doesnt have cache', () async {
      final response = await sut.getStringList(key: 'string_list_key');

      expect(response.data, isNull);
      expect(response.status, equals(CacheResponseStatus.notFound));
    });

    test('should be able to call getStringList and return NULL when cache is expired', () async {
      await sut.saveStringList(key: 'string_list_key', data: data);
      await Future.delayed(const Duration(milliseconds: 100));

      final response = await sut.getStringList(key: 'string_list_key');

      expect(response.data, isNull);
      expect(response.status, equals(CacheResponseStatus.expired));
    });
  });

  group('GetDataCacheIntegrationTest.getJsonList |', () {
    final json = {'key': 'value'};
    final data = List.generate(5, (_) => json);

    test('should be able to call getJsonList and return DATA when have cache', () async {
      await sut.saveJsonList(key: 'json_list_key', data: data);

      final response = await sut.getJsonList(key: 'json_list_key');

      expect(response.data, equals(data));
      expect(response.status, equals(CacheResponseStatus.success));
    });

    test('should be able to call getJsonList and return NULL when doesnt have cache', () async {
      final response = await sut.getJsonList(key: 'json_list_key');

      expect(response.data, isNull);
      expect(response.status, equals(CacheResponseStatus.notFound));
    });

    test('should be able to call getJsonList and return NULL when cache is expired', () async {
      await sut.saveJsonList(key: 'json_list_key', data: data);
      await Future.delayed(const Duration(milliseconds: 100));

      final response = await sut.getJsonList(key: 'json_list_key');

      expect(response.data, isNull);
      expect(response.status, equals(CacheResponseStatus.expired));
    });
  });
}
