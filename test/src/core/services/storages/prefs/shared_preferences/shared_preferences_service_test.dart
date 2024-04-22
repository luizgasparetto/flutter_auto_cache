import 'dart:convert';

import 'package:auto_cache_manager/src/core/services/storages/exceptions/storage_exceptions.dart';
import 'package:auto_cache_manager/src/core/services/storages/prefs/shared_preferences/shared_preferences_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesMock extends Mock implements SharedPreferences {}

void main() {
  final prefs = SharedPreferencesMock();
  final sut = SharedPreferencesService(prefs);

  tearDown(() {
    reset(prefs);
  });

  group('SharedPreferencesService.get |', () {
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
      expect(response, isA<String>());
      verify(() => prefs.getString('my_key')).called(1);
    });

    test('should be able to GET cache data and when not found, return NULL', () async {
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

  group('SharedPreferencesService.getKeys |', () {
    test('should be able to get keys of prefs successfully when has keys setted', () {
      when(() => prefs.getKeys()).thenReturn({'key1', 'key2'});

      final response = sut.getKeys();

      expect(response, isA<List<String>>());
      expect(response, equals(['key1', 'key2']));
      verify(() => prefs.getKeys()).called(1);
    });

    test('should be able to get EMPTY keys of prefs successfully', () {
      when(() => prefs.getKeys()).thenReturn({});

      final response = sut.getKeys();

      expect(response, isA<List<String>>());
      expect(response, isEmpty);
      verify(() => prefs.getKeys()).called(1);
    });

    test('should NOT be able to get keys when prefs failed', () {
      when(() => prefs.getKeys()).thenThrow(Exception());

      expect(() => sut.getKeys(), throwsA(isA<GetStorageKeysException>()));
      verify(() => prefs.getKeys()).called(1);
    });
  });

  group('SharedPreferencesService.save |', () {
    final data = {'data': 'my_data'};
    final encondedData = jsonEncode(data);

    test('should be able to SAVE cache data with key successfuly', () async {
      when(() => prefs.setString('my_key', encondedData)).thenAnswer((_) async => true);

      await expectLater(sut.save(key: 'my_key', data: encondedData), completes);
      verify(() => prefs.setString('my_key', any(that: isA<String>()))).called(1);
    });

    test('should NOT be able to SAVE cache data with key when prefs throws an Exception', () async {
      when(() => prefs.setString('my_key', any(that: isA<String>()))).thenThrow(Exception());

      expect(() => sut.save(key: 'my_key', data: encondedData), throwsA(isA<SaveStorageException>()));
      verify(() => prefs.setString('my_key', any(that: isA<String>()))).called(1);
    });
  });

  group('SharedPreferencesService.delete |', () {
    test('should be able to delete cache data by key successfully', () async {
      when(() => prefs.remove('key')).thenAnswer((_) async => true);

      await expectLater(sut.delete(key: 'key'), completes);
      verify(() => prefs.remove('key')).called(1);
    });

    test('should NOT be able to delete cache data when prefs fails', () async {
      when(() => prefs.remove('key')).thenThrow(Exception());

      expect(() => sut.delete(key: 'key'), throwsA(isA<DeleteStorageException>()));
      verify(() => prefs.remove('key')).called(1);
    });
  });

  group('SharedPreferencesService.clear |', () {
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
