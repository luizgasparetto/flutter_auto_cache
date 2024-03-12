import 'dart:convert';

import 'package:auto_cache_manager/src/core/services/storages/exceptions/storage_exceptions.dart';
import 'package:auto_cache_manager/src/core/services/storages/kvs/shared_preferences/shared_preferences_kvs_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesMock extends Mock implements SharedPreferences {}

void main() {
  final prefs = SharedPreferencesMock();
  final sut = SharedPreferencesKeyValueStorageService(prefs);

  tearDown(() {
    reset(prefs);
  });

  group('SharedPreferencesKeyValueStorageService.get |', () {
    final payloadBody = {
      'id': 'my_key',
      'data': 'my_data',
      'invalidation_type_code': 'generic_code',
      'created_at': DateTime.now().toIso8601String(),
    };

    test('should be able to GET cache data by key successfully', () async {
      when(() => prefs.getString('my_key')).thenReturn(jsonEncode(payloadBody));

      final response = sut.get<String>(key: 'my_key');

      expect(response, isNotNull);
      expect(response?.data, isA<String>());
      expect(response?.data, equals('my_data'));
      verify(() => prefs.getString('my_key')).called(1);
    });

    test('should be able to GET cache data and when not found, return null', () async {
      when(() => prefs.getString('my_key')).thenReturn(null);

      final response = sut.get<String>(key: 'my_key');

      expect(response, isNull);
      verify(() => prefs.getString('my_key')).called(1);
    });

    test('should NOT be able to GET cache data when prefs throws an Exception', () async {
      when(() => prefs.getString('my_key')).thenThrow(Exception());

      expect(() => sut.get<String>(key: 'my_key'), throwsA(isA<GetStorageException>()));
      verify(() => prefs.getString('my_key')).called(1);
    });
  });
}
