import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider/path_provider.dart';

class DirectoryMock extends Mock implements Directory {}

class FileSystemMock extends Mock implements FileSystemEntity {}

void main() {
  //final sut = CacheDetailsService();

  final mockKvsDirectory = DirectoryMock();
  final mockSqlDirectory = DirectoryMock();
  final mockFile = FileSystemMock();

  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);

  tearDown(() {
    reset(mockKvsDirectory);
    reset(mockSqlDirectory);
    reset(mockFile);
  });

  // setUpAll(() {
  //   TestWidg
  // });

  group('CacheDetailsService.getCacheSizeUsed |', () {
    test('description', () {
      when(getApplicationDocumentsDirectory).thenAnswer((_) async => mockKvsDirectory);

      expect(2 + 2, equals(4));
    });
  });
}
