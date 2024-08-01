abstract interface class IHttpService {
  Future getFile(String url, {Map<String, dynamic>? headers});
}
