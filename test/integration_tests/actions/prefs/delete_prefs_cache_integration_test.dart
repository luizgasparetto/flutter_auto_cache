import 'package:flutter_test/flutter_test.dart';

import '../../../commons/helpers/integration_test_helpers.dart';

Future<void> main() async {
  final sut = await initializePrefsController();

  group('DeleteCacheIntegrationTest |', () {
    test('should be able to call delete and NOT throw any exception when NOT found key', () async {
      await expectLater(sut.delete(key: 'my_key'), completes);
    });

    test('should be able to delete an existent cache item by key', () async {
      await sut.saveString(key: 'string_key', data: 'string_value');

      final response = await sut.getString(key: 'string_key');

      expect(response, equals('string_value'));

      await sut.delete(key: 'string_key');

      final deletedResponse = await sut.getString(key: 'string_key');

      expect(deletedResponse, isNull);
    });
  });
}
