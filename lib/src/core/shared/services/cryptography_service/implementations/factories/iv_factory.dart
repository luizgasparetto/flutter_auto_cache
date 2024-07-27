import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

/// A factory class for creating initialization vectors (IV) for encryption and decryption.
///
/// This class provides static methods for generating IVs for encryption and extracting IVs
/// from combined encrypted data for decryption.
class IvFactory {
  /// Creates a random IV for encryption.
  ///
  /// This method generates a 16-byte IV using a secure random number generator.
  ///
  /// Returns:
  ///   An [IV] object containing the generated initialization vector.
  static IV createEncryptIv() {
    final random = Random.secure();

    final ivBytes = List<int>.generate(16, (i) => random.nextInt(256));
    final base64Enconded = base64Url.encode(Uint8List.fromList(ivBytes));

    return IV.fromBase64(base64Enconded);
  }

  /// Extracts the IV from the beginning of a combined encrypted data.
  ///
  /// This method takes the first 16 bytes from the provided [combined] data and uses them
  /// as the IV for decryption.
  ///
  /// Args:
  ///   combined: A [Uint8List] containing the combined IV and encrypted data.
  ///
  /// Returns:
  ///   An [IV] object containing the extracted initialization vector.
  static IV createDecryptIv(Uint8List combined) {
    return IV(Uint8List.fromList(combined.sublist(0, 16)));
  }
}
