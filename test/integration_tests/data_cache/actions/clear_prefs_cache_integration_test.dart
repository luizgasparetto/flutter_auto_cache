import 'package:flutter_test/flutter_test.dart';

import '../../../commons/helpers/integration_test_helpers.dart';

Future<void> main() async {
  final sut = await initializePrefsController();

  group('ClearCacheIntegrationTest |', () {
    test('should be able to call clear and NOT throw any exception when NOT found keys', () async {
      await expectLater(sut.clear(), completes);
    });

    test('should be able to clear all existent cache successfully', () async {
      await sut.saveString(key: 'string_key', data: 'string_value');
      await sut.saveInt(key: 'int_key', data: 1);

      await expectLater(sut.clear(), completes);

      final stringResponse = sut.getString(key: 'string_key');
      final intResponse = sut.getInt(key: 'int_key');

      expect(stringResponse, isNull);
      expect(intResponse, isNull);
    });
  });
}
