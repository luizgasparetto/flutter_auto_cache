import 'package:flutter/foundation.dart';

@immutable
final class ErrorMethodDetails {
  final String method;
  final String errorLine;

  const ErrorMethodDetails({
    required this.method,
    required this.errorLine,
  });

  @override
  bool operator ==(covariant ErrorMethodDetails other) {
    if (identical(this, other)) return true;

    return other.method == method && other.errorLine == errorLine;
  }

  @override
  int get hashCode => method.hashCode ^ errorLine.hashCode;
}
