import 'dart:io';

/// Interface for the Path Provider Service.
///
/// This service provides methods to get directories for storing application-specific files.
abstract interface class IPathProviderService {
  /// Gets the directory for storing application documents.
  ///
  /// The application documents directory is a suitable place to store files that the user creates
  /// and manages, such as documents or other user-generated content.
  ///
  /// Returns a [Directory] representing the application documents directory.
  Future<Directory> getApplicationDocumentsDirectory();

  /// Gets the directory for storing application support files.
  ///
  /// The application support directory is a suitable place to store files that the app needs
  /// but which are not user-generated content, such as configuration files or other app-specific data.
  ///
  /// Returns a [Directory] representing the application support directory.
  Future<Directory> getApplicationSupportDirectory();
}
