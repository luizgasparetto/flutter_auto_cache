import 'package:cryptography/cryptography.dart';

class EncryptedData {
  final SecretBox data;

  const EncryptedData({
    required this.data,
  });
}
