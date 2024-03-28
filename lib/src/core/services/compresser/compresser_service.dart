import 'dart:convert';
import 'dart:io';

abstract interface class ICompresserService {
  String compressString(String value);
  String decompressString(String compress);
}

final class CompresserService implements ICompresserService {
  @override
  String compressString(String value) {
    final enCodedJson = utf8.encode(value);
    final gZipJson = gzip.encode(enCodedJson);
    return base64.encode(gZipJson);
  }

  @override
  String decompressString(String compress) {
    final decodeBase64Json = base64.decode(compress);
    final decodegZipJson = gzip.decode(decodeBase64Json);
    return utf8.decode(decodegZipJson);
  }
}
