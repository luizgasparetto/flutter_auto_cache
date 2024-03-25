// ignore_for_file: require_trailing_commas

import '../../../enums/invalidation_type.dart';
import '../invalidation_method.dart';

class TTLInvalidationMethod extends InvalidationMethod {
  final Duration duration;

  const TTLInvalidationMethod({this.duration = const Duration(days: 1)});

  @override
  InvalidationType get invalidationType => InvalidationType.ttl;
}
