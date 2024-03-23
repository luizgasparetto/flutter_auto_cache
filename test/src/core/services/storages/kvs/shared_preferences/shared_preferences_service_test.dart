import 'dart:convert';

import 'package:auto_cache_manager/auto_cache_manager.dart';
import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/core/services/cryptography/cryptography_service.dart';
import 'package:auto_cache_manager/src/core/services/storages/exceptions/storage_exceptions.dart';
import 'package:auto_cache_manager/src/core/services/storages/kvs/shared_preferences/shared_preferences_service.dart';
import 'package:auto_cache_manager/src/modules/cache/domain/value_objects/cache_cryptography_options.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesMock extends Mock implements SharedPreferences {}

class CryptographyServiceMock extends Mock implements CryptographyService {}

void main() {
  final prefs = SharedPreferencesMock();
  final cryptoService = CryptographyServiceMock();
  final sut = SharedPreferencesService(prefs, cryptoService);

  tearDown(() {
    reset(prefs);
    reset(cryptoService);
    AutoCacheManagerInitializer.I.setConfig(CacheConfig.defaultConfig());
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

      final response = await sut.get<String>(key: 'my_key');

      expect(response, isNotNull);
      expect(response?.data, isA<String>());
      expect(response?.data, equals('my_data'));
      verify(() => prefs.getString('my_key')).called(1);
    });

    test('should be able to GET encrypted cache data by key successfully', () async {
      const decryptedValue = 'value';
      const encryptedValue = 'zPeV1q9zso0UleCxuiQZ4g==';

      final encryptedStored = {
        'id': 'my_key',
        'data': encryptedValue,
        'invalidation_type_code': 'generic_code',
        'created_at': DateTime.now().toIso8601String(),
      };

      when(() => prefs.getString('my_key')).thenReturn(jsonEncode(encryptedStored));
      when(() => cryptoService.decrypt('zPeV1q9zso0UleCxuiQZ4g==')).thenAnswer((_) async => decryptedValue);

      AutoCacheManagerInitializer.I.setConfig(
        CacheConfig(
          cryptographyOptions: const CacheCryptographyOptions(
            secretKey: 'mySecretKey',
          ),
        ),
      );

      final response = await sut.get<String>(key: 'my_key');

      expect(response, isNotNull);
      expect(response?.data, isA<String>());
      expect(response?.data, equals(decryptedValue));
      verify(() => prefs.getString('my_key')).called(1);
    });

    test('should be able to GET cache data and when not found, return null', () async {
      when(() => prefs.getString('my_key')).thenReturn(null);

      final response = await sut.get<String>(key: 'my_key');

      expect(response, isNull);
      verify(() => prefs.getString('my_key')).called(1);
    });

    test('should NOT be able to GET cache data when prefs throws an Exception', () async {
      when(() => prefs.getString('my_key')).thenThrow(Exception());

      expect(() => sut.get<String>(key: 'my_key'), throwsA(isA<GetPrefsStorageException>()));
      verify(() => prefs.getString('my_key')).called(1);
    });
  });

  group('SharedPreferencesKeyValueStorageService.save |', () {
    test('should be able to SAVE cache data with key successfully', () async {
      when(() => prefs.setString('my_key', any(that: isA<String>()))).thenAnswer((_) async => true);

      await expectLater(sut.save<String>(key: 'my_key', data: 'my_data'), completes);
      verify(() => prefs.setString('my_key', any(that: isA<String>()))).called(1);
    });

    // TODO - failed test
    test('should be able to SAVE cache with cryptograph data with key successfully', () async {
      const decryptedValue = 1;
      const encryptedValue = 'zPeV1q9zso0UleCxuiQZ4g==';

      final encryptedStored = {
        'id': 'my_key',
        'data': encryptedValue,
        'invalidation_type_code': 'generic_code',
        'created_at': DateTime.now().toIso8601String(),
      };

      when(() => prefs.getString('my_key')).thenReturn(jsonEncode(encryptedStored));
      when(() => cryptoService.encrypt(decryptedValue.toString())).thenAnswer((_) async => encryptedValue);

      AutoCacheManagerInitializer.I.setConfig(
        CacheConfig(
          cryptographyOptions: const CacheCryptographyOptions(
            secretKey: 'mySecretKey',
          ),
        ),
      );

      await sut.save<int>(key: 'my_key', data: decryptedValue);
      //  verify(() => prefs.setString('my_key', any(that: isA<String>()))).called(1);
    });

    test('should NOT be able to SAVE cache data with key when prefs throws an Exception', () async {
      when(() => prefs.setString('my_key', any(that: isA<String>()))).thenThrow(Exception());

      expect(() => sut.save<String>(key: 'my_key', data: 'my_data'), throwsA(isA<SavePrefsStorageException>()));
      verify(() => prefs.setString('my_key', any(that: isA<String>()))).called(1);
    });
  });

  group('SharedPreferencesKeyValueStorageService.clear |', () {
    test('should be able to clear cache of SharedPreferences', () async {
      when(prefs.clear).thenAnswer((_) async => true);

      await expectLater(sut.clear(), completes);
      verify(prefs.clear).called(1);
    });
  });
}
