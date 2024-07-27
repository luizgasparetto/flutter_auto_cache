import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_auto_cache/src/core/shared/extensions/types/map_extensions.dart';

void main() {
  group('MapExtensions.updateValueByKey |', () {
    final map = {'data': 'my_data'};

    test('should be able to update map by key and return updated map', () {
      final updatedMap = map.updateValueByKey(
        key: 'data',
        newValue: 'new_data',
      );

      expect(updatedMap['data'], equals('new_data'));
    });
  });

  group('MapExtensions.updateKey |', () {
    final map = {'data': 'my_data'};

    test(
      'should be able to update key of a map and return the updated map',
      () {
        final updatedMap = map.updateKey(
          oldKey: 'data',
          newKey: 'new_data_key',
        );

        expect(updatedMap['new_data_key'], equals('my_data'));
      },
    );
  });
}
