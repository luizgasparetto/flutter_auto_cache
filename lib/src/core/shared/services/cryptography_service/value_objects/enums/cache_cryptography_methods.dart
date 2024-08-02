/// Defines cryptographic methods for encrypting and decrypting cache data
/// in the Flutter Auto Cache library.
enum CacheCryptographyMethods {
  /// AES (Advanced Encryption Standard) - symmetric encryption algorithm.
  aes,

  /// RSA (Rivest-Shamir-Adleman) - asymmetric encryption algorithm.
  rsa,

  /// Fernet - symmetric encryption algorithm.
  fernet,

  /// Salsa20 - stream cipher algorithm.
  salsa20,

  /// No encryption.
  none,
}
