import 'dart:io';

import '../i_path_provider_service.dart';
import 'package:path_provider/path_provider.dart' as path;

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
