import 'dart:io';

abstract interface class IDirectoryProvider {
  Future<Directory> getApplicationDocumentsDirectory();
  Future<Directory> getApplicationSupportDirectory();
}
