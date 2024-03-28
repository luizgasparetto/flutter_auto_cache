import 'package:auto_cache_manager/src/core/core.dart';

import '../../../enums/invalidation_type.dart';
import '../invalidation_method.dart';

class TTLInvalidationMethod extends InvalidationMethod {
  final Duration duration;

  const TTLInvalidationMethod({this.duration = CacheConstants.maxTtlDuration});

  @override
  InvalidationType get invalidationType => InvalidationType.ttl;
}
