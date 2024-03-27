abstract interface class ICryptographyService {
  Future<String> encrypt(String encrypted);
  Future<String> decrypt(String decrypted);
}
