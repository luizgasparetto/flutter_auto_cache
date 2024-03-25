import '../../enums/invalidation_type.dart';

abstract class InvalidationMethod {
  InvalidationType get invalidationType;
}
