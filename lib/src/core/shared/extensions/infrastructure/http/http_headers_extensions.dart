import 'dart:io';

import '../../nullable_extensions.dart';

extension HeadersAddAllExtension on HttpHeaders {
  void addAll(Map<String, dynamic>? headers) {
    headers.let((values) => values.forEach((key, value) => this.set(key, value)));
  }
}
