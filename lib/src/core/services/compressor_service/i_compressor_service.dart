/// An abstract interface for string compression and decompression services.
abstract interface class ICompressorService {
  /// Compresses the provided string and returns the compressed result.
  ///
  /// This method takes a [value] as input, which is the string to be compressed.
  /// The compressed version of the string is returned as a [String].
  ///
  /// [value]: The string to be compressed.
  ///
  /// Returns the compressed string.
  String compressString(String value);

  /// Decompresses the provided compressed string and returns the original string.
  ///
  /// This method takes a [compress] as input, which is the compressed string to be decompressed.
  /// The original version of the string is returned as a [String].
  ///
  /// [compress]: The compressed string to be decompressed.
  ///
  /// Returns the original decompressed string.
  String decompressString(String compress);
}
