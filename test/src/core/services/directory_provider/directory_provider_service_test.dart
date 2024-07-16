import 'dart:io';

import 'package:flutter_auto_cache/src/core/errors/auto_cache_error.dart';
import 'package:flutter_auto_cache/src/core/services/directory_service/directory_provider_service.dart';
import 'package:flutter_auto_cache/src/core/services/path_provider_service/i_path_provider_service.dart';
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
    });
  });

  group('DirectoryProviderService.prefsDirectory |', () {
    test('should be able to get prefs directory from state value', () async {
      when(service.getApplicationDocumentsDirectory).thenAnswer((_) async => Directory(any()));
      when(service.getApplicationSupportDirectory).thenAnswer((_) async => Directory(any()));

      await expectLater(sut.getCacheDirectories(), completes);
      expect(sut.value.isLoaded, isTrue);
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
