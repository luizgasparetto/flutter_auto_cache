/// An abstract interface for a cryptography service.
///
/// This interface defines the methods for encrypting and decrypting data.
abstract interface class ICryptographyService {
  /// Encrypts the given data.
  ///
  /// This method takes a plain text string and returns its encrypted form.
  ///
  /// Args:
  ///   data: A [String] representing the plain text data to be encrypted.
  ///
  /// Returns:
  ///   A [String] containing the encrypted data.
  String encrypt(String data);

  /// Decrypts the given encrypted data.
  ///
  /// This method takes an encrypted string and returns its decrypted (plain text) form.
  ///
  /// Args:
  ///   encrypted: A [String] representing the encrypted data to be decrypted.
  ///
  /// Returns:
  ///   A [String] containing the decrypted (plain text) data.
  String decrypt(String encrypted);
}
