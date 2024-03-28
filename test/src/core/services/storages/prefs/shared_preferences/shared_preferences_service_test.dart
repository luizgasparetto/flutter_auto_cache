import 'dart:convert';

import 'package:auto_cache_manager/src/core/services/compresser/compresser_service.dart';
import 'package:auto_cache_manager/src/core/services/storages/exceptions/storage_exceptions.dart';
import 'package:auto_cache_manager/src/core/services/storages/prefs/shared_preferences/shared_preferences_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesMock extends Mock implements SharedPreferences {}

class CompresserServiceMock extends Mock implements ICompresserService {}

void main() {
  final prefs = SharedPreferencesMock();
  final compresser = CompresserServiceMock();
  final sut = SharedPreferencesService(prefs, compresser);

  tearDown(() {
    reset(prefs);
    reset(compresser);
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

      final response = sut.get(key: 'my_key');

      expect(response, isNotNull);
      expect(response?['data'], isA<String>());
      expect(response?['data'], equals('my_data'));
      verify(() => prefs.getString('my_key')).called(1);
    });

    test('should be able to GET cache data and when not found, return null', () async {
      when(() => prefs.getString('my_key')).thenReturn(null);

      final response = sut.get(key: 'my_key');

      expect(response, isNull);
      verify(() => prefs.getString('my_key')).called(1);
    });

    test('should NOT be able to GET cache data when prefs throws an Exception', () async {
      when(() => prefs.getString('my_key')).thenThrow(Exception());

      expect(() => sut.get(key: 'my_key'), throwsA(isA<GetStorageException>()));
      verify(() => prefs.getString('my_key')).called(1);
    });
  });

  group('SharedPreferencesKeyValueStorageService.save |', () {
    test('should be able to SAVE cache data with key successfuly', () async {
      when(() => prefs.setString('my_key', any(that: isA<String>()))).thenAnswer((_) async => true);

      await expectLater(sut.save(key: 'my_key', data: {'data': 'my_data'}), completes);
      verify(() => prefs.setString('my_key', any(that: isA<String>()))).called(1);
    });

    test('should NOT be able to SAVE cache data with key when prefs throws an Exception', () async {
      when(() => prefs.setString('my_key', any(that: isA<String>()))).thenThrow(Exception());

      expect(() => sut.save(key: 'my_key', data: {'data': 'my_data'}), throwsA(isA<SaveStorageException>()));
      verify(() => prefs.setString('my_key', any(that: isA<String>()))).called(1);
    });
  });

  group('SharedPreferencesKeyValueStorageService.clear |', () {
    test('should be able to clear cache of SharedPreferences', () async {
      when(prefs.clear).thenAnswer((_) async => true);

      await expectLater(sut.clear(), completes);
      verify(prefs.clear).called(1);
    });

    test('should NOT be able to clear cache of prefs when SharedPreferences fails', () async {
      when(prefs.clear).thenThrow(Exception());

      expect(sut.clear, throwsA(isA<ClearStorageException>()));
      verify(prefs.clear).called(1);
    });
  });
}
