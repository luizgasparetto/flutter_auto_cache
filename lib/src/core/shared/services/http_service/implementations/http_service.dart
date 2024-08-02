import 'dart:async';
import 'dart:io';

import '../file_responses/http_file_response.dart';
import '../i_http_service.dart';

import '../../../extensions/infrastructure/http/http_headers_extensions.dart';
import '../../../extensions/infrastructure/http/http_response_extensions.dart';

import '../../../extensions/infrastructure/streams/stream_extensions.dart';

final class HttpService implements IHttpService {
  final HttpClient client;

  const HttpService(this.client);

  @override
  Future<FileResponse> getFile(String url, {Map<String, dynamic>? headers}) async {
    final streamController = StreamController<List<int>>();
    final response = await _request(url, headers: headers);

    if (response.isSuccessful) response.interact(streamController);

    return FileResponse(bytes: streamController.stream, statusCode: response.statusCode);
  }

  Future<HttpClientResponse> _request(String url, {Map<String, dynamic>? headers}) async {
    final request = await client.getUrl(Uri.parse(url));
    request.headers.addAll(headers);

    return request.close();
  }
}
