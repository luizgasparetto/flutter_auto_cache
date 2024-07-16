import 'package:flutter_test/flutter_test.dart';

Matcher isLessThan(num value) => _IsLessThan(value);

class _IsLessThan extends Matcher {
  final num value;

  _IsLessThan(this.value);

  @override
  bool matches(item, Map matchState) {
    if (item is! num) return false;

    return item < value;
  }

  @override
  Description describe(Description description) => description.add('a value less than ').addDescriptionOf(value);
}
