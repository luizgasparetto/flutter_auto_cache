import 'dart:io';

import '../directory_provider.dart';

final class PathProviderDirectoryProvider implements IDirectoryProvider {
  @override
  Future<Directory> getApplicationDocumentsDirectory() async {
    return getApplicationDocumentsDirectory();
  }

  @override
  Future<Directory> getApplicationSupportDirectory() {
    return getApplicationSupportDirectory();
  }
}
