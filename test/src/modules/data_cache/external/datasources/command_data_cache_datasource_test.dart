import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/core/services/cryptography/i_cryptography_service.dart';
import 'package:auto_cache_manager/src/core/services/storages/prefs/i_prefs_service.dart';
import 'package:auto_cache_manager/src/modules/data_cache/domain/dtos/save_cache_dto.dart';
import 'package:auto_cache_manager/src/modules/data_cache/external/datasources/command_data_cache_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../commons/extensions/when_extensions.dart';

class PrefsServiceMock extends Mock implements IPrefsService {}

class CryptographyServiceMock extends Mock implements ICryptographyService {}

class FakeAutoCacheManagerException extends Fake implements AutoCacheManagerException {}

void main() {
  final prefsService = PrefsServiceMock();
  final cryptographyService = CryptographyServiceMock();

  final sut = CommandDataCacheDatasource(prefsService, cryptographyService);

  tearDown(() {
    reset(prefsService);
    reset(cryptographyService);
  });

  group('CommandDataCacheDatasource.save |', () {
    final config = CacheConfig.defaultConfig();
    final dto = SaveCacheDTO<String>(key: 'my_key', data: 'data', cacheConfig: config);

    Matcher matcher() {
      return predicate<String>((json) => json.contains('data') && json.contains('my_key'));
    }

    test('should be able to save data in prefs cache succesfully', () async {
      when(() => cryptographyService.encrypt(any(that: matcher()))).thenReturn('any_encrypted');
      when(() => prefsService.save(key: 'my_key', data: 'any_encrypted')).thenAsyncVoid();

      await expectLater(sut.save(dto), completes);
      verify(() => prefsService.save(key: 'my_key', data: 'any_encrypted')).called(1);
    });

    test('should NOT be able to save data in prefs when service fails', () async {
      when(() => cryptographyService.encrypt(any(that: matcher()))).thenReturn('any_encrypted');
      when(() => prefsService.save(key: 'my_key', data: 'any_encrypted')).thenThrow(FakeAutoCacheManagerException());

      expect(() => sut.save(dto), throwsA(isA<AutoCacheManagerException>()));
      verify(() => prefsService.save(key: 'my_key', data: 'any_encrypted')).called(1);
    });
  });

  group('CommandDataCacheDatasource.delete |', () {
    test('should be able to delete data in prefs cache successfully', () async {
      when(() => prefsService.delete(key: 'my_key')).thenAsyncVoid();

      await expectLater(sut.delete('my_key'), completes);
      verify(() => prefsService.delete(key: 'my_key')).called(1);
    });

    test('should NOT be able to delete data in prefs cache when service fails', () async {
      when(() => prefsService.delete(key: 'my_key')).thenThrow(FakeAutoCacheManagerException());

      expect(() => sut.delete('my_key'), throwsA(isA<AutoCacheManagerException>()));
      verify(() => prefsService.delete(key: 'my_key')).called(1);
    });
  });

  group('CommandDataCacheDatasource.clear |', () {
    test('should be able to clear prefs cache data successfully', () async {
      when(prefsService.clear).thenAsyncVoid();

      await expectLater(sut.clear(), completes);
      verify(prefsService.clear).called(1);
    });

    test('should NOT be able to clear prefs when service fails', () async {
      when(prefsService.clear).thenThrow(FakeAutoCacheManagerException());

      expect(sut.clear, throwsA(isA<AutoCacheManagerException>()));
      verify(prefsService.clear).called(1);
    });
  });
}
