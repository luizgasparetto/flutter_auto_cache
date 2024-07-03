import 'package:flutter_auto_cache/flutter_auto_cache.dart';
import 'package:flutter_auto_cache/src/core/services/cryptography_service/i_cryptography_service.dart';
import 'package:flutter_auto_cache/src/core/services/kvs_service/i_kvs_service.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/domain/dtos/write_cache_dto.dart';
import 'package:flutter_auto_cache/src/modules/data_cache/external/datasources/command_data_cache_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../commons/extensions/when_extensions.dart';

class KvsServiceMock extends Mock implements IKvsService {}

class CryptographyServiceMock extends Mock implements ICryptographyService {}

class FakeAutoCacheException extends Fake implements AutoCacheException {}

void main() {
  final kvsService = KvsServiceMock();
  final cryptographyService = CryptographyServiceMock();

  final sut = CommandDataCacheDatasource(kvsService, cryptographyService);

  tearDown(() {
    reset(kvsService);
    reset(cryptographyService);
  });

  group('CommandDataCacheDatasource.save |', () {
    final config = CacheConfiguration.defaultConfig();
    final dto = WriteCacheDTO<String>(key: 'my_key', data: 'data', cacheConfig: config);

    Matcher matcher() {
      return predicate<String>((json) => json.contains('data') && json.contains('my_key'));
    }

    test('should be able to save data in prefs cache succesfully', () async {
      when(() => cryptographyService.encrypt(any(that: matcher()))).thenReturn('any_encrypted');
      when(() => kvsService.save(key: 'my_key', data: 'any_encrypted')).thenAsyncVoid();

      await expectLater(sut.save(dto), completes);
      verify(() => kvsService.save(key: 'my_key', data: 'any_encrypted')).called(1);
    });

    test('should NOT be able to save data in prefs when service fails', () async {
      when(() => cryptographyService.encrypt(any(that: matcher()))).thenReturn('any_encrypted');
      when(() => kvsService.save(key: 'my_key', data: 'any_encrypted')).thenThrow(FakeAutoCacheException());

      expect(() => sut.save(dto), throwsA(isA<AutoCacheException>()));
      verify(() => kvsService.save(key: 'my_key', data: 'any_encrypted')).called(1);
    });
  });

  group('CommandDataCacheDatasource.delete |', () {
    test('should be able to delete data in prefs cache successfully', () async {
      when(() => kvsService.delete(key: 'my_key')).thenAsyncVoid();

      await expectLater(sut.delete('my_key'), completes);
      verify(() => kvsService.delete(key: 'my_key')).called(1);
    });

    test('should NOT be able to delete data in prefs cache when service fails', () async {
      when(() => kvsService.delete(key: 'my_key')).thenThrow(FakeAutoCacheException());

      expect(() => sut.delete('my_key'), throwsA(isA<AutoCacheException>()));
      verify(() => kvsService.delete(key: 'my_key')).called(1);
    });
  });

  group('CommandDataCacheDatasource.clear |', () {
    test('should be able to clear prefs cache data successfully', () async {
      when(kvsService.clear).thenAsyncVoid();

      await expectLater(sut.clear(), completes);
      verify(kvsService.clear).called(1);
    });

    test('should NOT be able to clear prefs when service fails', () async {
      when(kvsService.clear).thenThrow(FakeAutoCacheException());

      expect(sut.clear, throwsA(isA<AutoCacheException>()));
      verify(kvsService.clear).called(1);
    });
  });
}
