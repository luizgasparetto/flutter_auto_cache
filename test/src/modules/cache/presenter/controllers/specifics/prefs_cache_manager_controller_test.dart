import 'package:auto_cache_manager/src/core/core.dart';
import 'package:auto_cache_manager/src/modules/cache/presenter/controllers/base_cache_manager_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../extensions/when_extensions.dart';

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
      when(() => baseController.save<String>(key: 'my_key', data: 'my_data')).thenThrow(
        FakeAutoCacheManagerException(),
      );

      expect(() => sut.saveString(key: 'my_key', data: 'my_data'), throwsA(isA<AutoCacheManagerException>()));
      verify(() => baseController.save<String>(key: 'my_key', data: 'my_data')).called(1);
    });
  });

  group('PrefsCacheManagerController.getInt |', () {
    test('should be able to get int data in prefs successfully', () async {
      when(() => baseController.get<int>(key: 'id_key')).thenAnswer((_) async => 1);

      final response = await sut.getInt(key: 'id_key');

      expect(response, equals(1));
      verify(() => baseController.get<int>(key: 'id_key')).called(1);
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
}
