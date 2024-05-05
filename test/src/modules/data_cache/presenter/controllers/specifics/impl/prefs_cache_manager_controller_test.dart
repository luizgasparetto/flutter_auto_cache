import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/modules/data_cache/presenter/controllers/base_cache_manager_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../commons/extensions/when_extensions.dart';

class BaseCacheManagerControllerMock extends Mock implements BaseCacheManagerController {}

class FakeAutoCacheManagerException extends Fake implements AutoCacheManagerException {}

void main() {
  final baseController = BaseCacheManagerControllerMock();
  final sut = PrefsCacheManagerController(baseController);

  tearDown(() {
    reset(baseController);
  });

  group('PrefsCacheManagerController.getString |', () {
    test('should be able to get string by key successfully', () async {
      when(() => baseController.get<String>(key: 'my_key')).thenAnswer((_) async => 'cached_data');

      final response = await sut.getString(key: 'my_key');

      expect(response, equals('cached_data'));
      verify(() => baseController.get<String>(key: 'my_key')).called(1);
    });

    test('should be able to get NULL when request an non existent string cache', () async {
      when(() => baseController.get<String>(key: 'my_key')).thenAnswer((_) async => null);

      final response = await sut.getString(key: 'my_key');

      expect(response, isNull);
      verify(() => baseController.get<String>(key: 'my_key')).called(1);
    });

    test('should NOT be able to get string by key when base controller fails', () async {
      when(() => baseController.get<String>(key: 'my_key')).thenThrow(FakeAutoCacheManagerException());

      expect(() => sut.getString(key: 'my_key'), throwsA(isA<AutoCacheManagerException>()));
      verify(() => baseController.get<String>(key: 'my_key')).called(1);
    });
  });

  group('PrefsCacheManagerController.saveString |', () {
    test('should be able to save string in prefs successfully', () async {
      when(() => baseController.save<String>(key: 'my_key', data: 'my_data')).thenAsyncVoid();

      await expectLater(sut.saveString(key: 'my_key', data: 'my_data'), completes);
      verify(() => baseController.save<String>(key: 'my_key', data: 'my_data')).called(1);
    });

    test('should NOT be able to save string in prefs when base controller fails', () async {
      when(() => baseController.save<String>(key: 'key', data: 'data')).thenThrow(FakeAutoCacheManagerException());

      expect(() => sut.saveString(key: 'key', data: 'data'), throwsA(isA<AutoCacheManagerException>()));
      verify(() => baseController.save<String>(key: 'key', data: 'data')).called(1);
    });
  });

  group('PrefsCacheManagerController.getInt |', () {
    test('should be able to get int data in prefs successfully', () async {
      when(() => baseController.get<int>(key: 'id_key')).thenAnswer((_) async => 1);

      final response = await sut.getInt(key: 'id_key');

      expect(response, equals(1));
      verify(() => baseController.get<int>(key: 'id_key')).called(1);
    });

    test('should be able to get NULL when request an non existent int cache', () async {
      when(() => baseController.get<int>(key: 'my_key')).thenAnswer((_) async => null);

      final response = await sut.getInt(key: 'my_key');

      expect(response, isNull);
      verify(() => baseController.get<int>(key: 'my_key')).called(1);
    });

    test('should NOT be able to get int data when base controller fails', () async {
      when(() => baseController.get<int>(key: 'my_key')).thenThrow(FakeAutoCacheManagerException());

      expect(() => sut.getInt(key: 'my_key'), throwsA(isA<AutoCacheManagerException>()));
      verify(() => baseController.get<int>(key: 'my_key')).called(1);
    });
  });

  group('PrefsCacheManagerController.saveInt |', () {
    test('should be able to save int in prefs successfully', () async {
      when(() => baseController.save<int>(key: 'my_key', data: 1)).thenAsyncVoid();

      await expectLater(sut.saveInt(key: 'my_key', data: 1), completes);
      verify(() => baseController.save<int>(key: 'my_key', data: 1)).called(1);
    });

    test('should NOT be able to save int in prefs when base controller fails', () async {
      when(() => baseController.save<int>(key: 'my_key', data: 1)).thenThrow(FakeAutoCacheManagerException());

      expect(() => sut.saveInt(key: 'my_key', data: 1), throwsA(isA<AutoCacheManagerException>()));
      verify(() => baseController.save<int>(key: 'my_key', data: 1)).called(1);
    });
  });

  group('PrefsCacheManagerController.getJson |', () {
    test('should be able to get json in prefs successfully', () async {
      when(() => baseController.get<Map<String, dynamic>>(key: 'key')).thenAnswer((_) async => <String, dynamic>{});

      final response = await sut.getJson(key: 'key');

      expect(response, equals(<String, dynamic>{}));
      verify(() => baseController.get<Map<String, dynamic>>(key: 'key')).called(1);
    });

    test('should be able to get NULL when request an non existent JSON cache', () async {
      when(() => baseController.get<Map<String, dynamic>>(key: 'key')).thenAnswer((_) async => null);

      final response = await sut.getJson(key: 'key');

      expect(response, isNull);
      verify(() => baseController.get<Map<String, dynamic>>(key: 'key')).called(1);
    });

    test('should NOT be able to get json in prefs when base controller fails', () async {
      when(() => baseController.get<Map<String, dynamic>>(key: 'key')).thenThrow(FakeAutoCacheManagerException());

      expect(() => sut.getJson(key: 'key'), throwsA(isA<AutoCacheManagerException>()));
      verify(() => baseController.get<Map<String, dynamic>>(key: 'key')).called(1);
    });
  });

  group('PrefsCacheManagerController.saveJson |', () {
    test('should be able to save json in prefs successfully', () async {
      when(() => baseController.save<Map<String, dynamic>>(key: 'key', data: {})).thenAsyncVoid();

      await expectLater(sut.saveJson(key: 'key', data: {}), completes);
      verify(() => baseController.save<Map<String, dynamic>>(key: 'key', data: {})).called(1);
    });

    test('should NOT be able to save json in prefs when base controller fails', () async {
      when(() => baseController.save<Map<String, dynamic>>(key: 'key', data: {})).thenThrow(
        FakeAutoCacheManagerException(),
      );

      expect(() => sut.saveJson(key: 'key', data: {}), throwsA(isA<AutoCacheManagerException>()));
      verify(() => baseController.save<Map<String, dynamic>>(key: 'key', data: {})).called(1);
    });
  });

  group('PrefsCacheManagerController.getStringList |', () {
    test('should be able to get list of String in prefs successfully', () async {
      when(() => baseController.get<List<String>>(key: 'my_key')).thenAnswer((_) async => ['value']);

      final response = await sut.getStringList(key: 'my_key');

      expect(response?.length, equals(1));
      verify(() => baseController.get<List<String>>(key: 'my_key')).called(1);
    });

    test('should be able to get NULL when request a list of String that doesnt exists in cache', () async {
      when(() => baseController.get<List<String>>(key: 'my_key')).thenAnswer((_) async => null);

      final response = await sut.getStringList(key: 'my_key');

      expect(response, isNull);
      verify(() => baseController.get<List<String>>(key: 'my_key')).called(1);
    });

    test('should NOT be able to save a list of String when base controller fails', () async {
      when(() => baseController.get<List<String>>(key: 'my_key')).thenThrow(FakeAutoCacheManagerException());

      expect(() => sut.getStringList(key: 'my_key'), throwsA(isA<AutoCacheManagerException>()));
      verify(() => baseController.get<List<String>>(key: 'my_key')).called(1);
    });
  });

  group('PrefsCacheManagerController.saveStringList |', () {
    final data = ['value_1', 'value_2'];

    test('should be able to save a list of T in prefs successfully', () async {
      when(() => baseController.save<List<String>>(key: 'my_key', data: data)).thenAsyncVoid();

      await expectLater(sut.saveStringList(key: 'my_key', data: data), completes);
      verify(() => baseController.save<List<String>>(key: 'my_key', data: data)).called(1);
    });

    test('should NOT be able save a list of T in prefs when base controller fails', () async {
      when(() => baseController.save<List<String>>(key: 'my_key', data: data)).thenThrow(
        FakeAutoCacheManagerException(),
      );

      expect(() => sut.saveStringList(key: 'my_key', data: data), throwsA(isA<AutoCacheManagerException>()));
      verify(() => baseController.save<List<String>>(key: 'my_key', data: data)).called(1);
    });
  });

  group('PrefsCacheManagerController.delete |', () {
    test('should be able to delete data in cache successfully', () async {
      when(() => baseController.delete(key: 'my_key')).thenAsyncVoid();

      await expectLater(sut.delete(key: 'my_key'), completes);
      verify(() => baseController.delete(key: 'my_key')).called(1);
    });

    test('should NOT be able to delete data in cache when base controller fails', () async {
      when(() => baseController.delete(key: 'my_key')).thenThrow(FakeAutoCacheManagerException());

      expect(() => sut.delete(key: 'my_key'), throwsA(isA<AutoCacheManagerException>()));
      verify(() => baseController.delete(key: 'my_key')).called(1);
    });
  });

  group('PrefsCacheManagerController.clear |', () {
    test('should be able to clear all cache data from prefs successfully', () async {
      when(() => baseController.clear()).thenAsyncVoid();

      await expectLater(sut.clear(), completes);
      verify(() => baseController.clear()).called(1);
    });

    test('should NOT be able to clear all cache data from prefs when base controller fails', () async {
      when(() => baseController.clear()).thenThrow(FakeAutoCacheManagerException());

      expect(() => sut.clear(), throwsA(isA<AutoCacheManagerException>()));
      verify(() => baseController.clear()).called(1);
    });
  });
}
