import 'dart:convert';
import 'dart:io';

abstract interface class ICompresserService {
  String compressJson(String jsonEncoded);
  String decompressJson(String compress);
}

final class CompresserService implements ICompresserService {
  @override
  String compressJson(String jsonEncoded) {
    final enCodedJson = utf8.encode(jsonEncoded);
    final gZipJson = gzip.encode(enCodedJson);
    return base64.encode(gZipJson);
  }

  @override
  String decompressJson(String compress) {
    final decodeBase64Json = base64.decode(compress);
    final decodegZipJson = gzip.decode(decodeBase64Json);
    return utf8.decode(decodegZipJson);
  }
}
