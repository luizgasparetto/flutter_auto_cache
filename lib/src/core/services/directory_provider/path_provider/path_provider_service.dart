// coverage:ignore-file

import 'dart:io';

import 'package:path_provider/path_provider.dart' as path;

abstract interface class IPathProviderService {
  Future<Directory> getApplicationDocumentsDirectory();
  Future<Directory> getApplicationSupportDirectory();
}

class PathProviderService implements IPathProviderService {
  @override
  Future<Directory> getApplicationDocumentsDirectory() async {
    return path.getApplicationDocumentsDirectory();
  }

  @override
  Future<Directory> getApplicationSupportDirectory() async {
    return path.getApplicationSupportDirectory();
  }
}
