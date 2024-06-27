import 'dart:io';

import 'package:flutter_auto_cache/src/core/core.dart';
import 'package:flutter_auto_cache/src/core/services/directory_service/exceptions/directory_provider_exceptions.dart';
import 'package:flutter_auto_cache/src/core/services/directory_service/path_provider/path_provider_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class PathProviderServiceMock extends Mock implements IPathProviderService {}

class FakeAutoCacheManagerException extends Fake implements AutoCacheException {}

void main() {
  final service = PathProviderServiceMock();
  final sut = DirectoryProviderService(service);

  tearDown(() {
    sut.reset();
    reset(service);
  });

  group('DirectoryProviderService.getCacheDirectories |', () {
    test('should be able to load all directories successfully and set loaded state', () async {
      when(service.getApplicationDocumentsDirectory).thenAnswer((_) async => Directory(''));
      when(service.getApplicationSupportDirectory).thenAnswer((_) async => Directory(''));

      await expectLater(sut.getCacheDirectories(), completes);
      expect(sut.value.isLoaded, isTrue);
      verify(service.getApplicationDocumentsDirectory).called(1);
      verify(service.getApplicationSupportDirectory).called(1);
    });

    test('should NOT be able to load all directories when state is already loaded', () async {
      when(service.getApplicationDocumentsDirectory).thenAnswer((_) async => Directory(''));
      when(service.getApplicationSupportDirectory).thenAnswer((_) async => Directory(''));

      await expectLater(sut.getCacheDirectories(), completes);
      await expectLater(sut.getCacheDirectories(), completes);

      expect(sut.value.isLoaded, isTrue);
      verify(service.getApplicationDocumentsDirectory).called(1);
      verify(service.getApplicationSupportDirectory).called(1);
    });

    test('should NOT be able to load directories when getApplicationDocumentsDirectory fails', () async {
      when(service.getApplicationDocumentsDirectory).thenThrow(FakeAutoCacheManagerException());

      expect(sut.getCacheDirectories, throwsA(isA<DirectoryProviderException>()));
      expect(sut.value.isLoaded, isFalse);
      verify(service.getApplicationDocumentsDirectory).called(1);
      verifyNever(service.getApplicationSupportDirectory);
    });

    test('should NOT be able to load directories when getApplicationSupportDirectory fails', () async {
      when(service.getApplicationDocumentsDirectory).thenAnswer((_) async => Directory(''));
      when(service.getApplicationSupportDirectory).thenThrow(FakeAutoCacheManagerException());

      expect(sut.getCacheDirectories, throwsA(isA<DirectoryProviderException>()));
      expect(sut.value.isLoaded, isFalse);
      verify(service.getApplicationDocumentsDirectory).called(1);
    });
  });

  group('DirectoryProviderService.prefsDirectory |', () {
    test('should be able to get prefs directory from state value', () async {
      when(service.getApplicationDocumentsDirectory).thenAnswer(
        (_) async => Directory('docs_directory'),
      );
      when(service.getApplicationSupportDirectory).thenAnswer(
        (_) async => Directory('support_directory'),
      );

      await expectLater(sut.getCacheDirectories(), completes);
      expect(sut.value.isLoaded, isTrue);
      expect(sut.prefsDirectory.path, equals('docs_directory'));
    });
  });

  group('DirectoryProviderService.reset |', () {
    test('should be able to reset directory provider state value to empty', () async {
      when(service.getApplicationDocumentsDirectory).thenAnswer((_) async => Directory('docs_directory'));
      when(service.getApplicationSupportDirectory).thenAnswer((_) async => Directory('support_directory'));

      await expectLater(sut.getCacheDirectories(), completes);

      sut.reset();

      expect(sut.value.isLoaded, isFalse);
    });
  });
}
