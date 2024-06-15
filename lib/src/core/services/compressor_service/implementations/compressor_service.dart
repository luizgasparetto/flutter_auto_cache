import 'dart:convert';
import 'dart:io';

import '../i_compressor_service.dart';

/// A service implementation of the [ICompressorService] interface.
///
/// This class provides methods to compress and decompress strings using base64 and gzip encoding.
class CompressorService implements ICompressorService {
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
