import 'dart:io';

extension HttpResponseGettersExtension on HttpClientResponse {
  bool get isSuccessful => statusCode >= 200 && statusCode <= 299;
}
