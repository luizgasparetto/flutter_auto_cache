import 'package:flutter_auto_cache/src/core/extensions/string_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MbStringExtension.mbUsed |', () {
    test('should be able to get mb used by an example string', () {
      final strings = List.generate(100, (_) => 'example_string');

      final buffer = StringBuffer();
      buffer.writeAll(strings);

      final response = buffer.toString().kbUsed;

      expect(response, equals(1.3672));
    });
  });
}
