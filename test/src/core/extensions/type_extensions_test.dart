import 'package:flutter_auto_cache/src/core/extensions/types/type_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TypeExtensions.isList |', () {
    test('should be able to verify if type is a List', () {
      const type = List<String>;
      expect(type.isList, isTrue);
    });

    test('should be able to verify when type is NOT a List', () {
      const type = String;
      expect(type.isList, isFalse);
    });
  });
}
