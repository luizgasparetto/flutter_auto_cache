// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter_test/flutter_test.dart';

import '../../../../commons/extensions/matcher_extensions.dart';
import '../../../../commons/helpers/integration_test_helpers.dart';

Future<void> main() async {
  final sut = await initializeDataController();

  group('WriteDataCacheFitnessFunction |', () {
    const writeQuantity = 10000;

    test('should be able to 10000x write data cache in less than 3000ms', () async {
      final stopwatch = Stopwatch()..start();

      final valueList = List.generate(writeQuantity, (index) => 'value-$index');
      valueList.indexed.forEach((value) => sut.saveString(key: 'key-${value.$1}', data: value.$2));

      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, isLessThan(3000));
    });
  });
}
