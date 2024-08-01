import 'package:flutter/foundation.dart';

import '../../../../functional/equals.dart';

@immutable
final class ErrorMethodDetails extends Equals {
  final String method;
  final String errorLine;

  const ErrorMethodDetails({
    required this.method,
    required this.errorLine,
  });

  @override
  List<Object?> get props => [method, errorLine];
}
