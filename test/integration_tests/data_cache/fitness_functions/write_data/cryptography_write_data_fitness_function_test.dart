import 'package:flutter_auto_cache/flutter_auto_cache.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../commons/extensions/matcher_extensions.dart';
import '../../../../commons/helpers/integration_test_helpers.dart';

Future<void> main() async {
  final config = CacheConfiguration(cryptographyOptions: CacheCryptographyOptions(secretKey: 'my_key'));
  final sut = await initializeDataController(config: config);

  group('CryptographyWriteDataFitnessFunction |', () {
    const writeQuantity = 10000;

    test('should be able to write 10000x cryptography data in less than 3000ms', () {
      final stopwatch = Stopwatch()..start();

      final valueList = List.generate(writeQuantity, (index) => 'value-$index');
      valueList.indexed.forEach((value) => sut.saveString(key: 'key-${value.$1}', data: value.$2));

      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, isLessThan(3000));
    });
  });
}
