import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../compresser/compresser_service.dart';
import '../../exceptions/storage_exceptions.dart';
import '../i_prefs_service.dart';

class SharedPreferencesService implements IPrefsService {
  final SharedPreferences prefs;
  final ICompresserService compresserService;

  const SharedPreferencesService(this.prefs, this.compresserService);

  @override
  Map<String, dynamic>? get({required String key}) {
    try {
      final response = prefs.getString(key);

      if (response == null) return null;

      return jsonDecode(response);
    } catch (e, stackTrace) {
      throw GetStorageException(
        code: 'get_prefs_storage_exception',
        message: 'Get Prefs Storage exception',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> save({required String key, required Map<String, dynamic> data}) async {
    try {
      final jsonEncoded = jsonEncode(data);

      await prefs.setString(key, jsonEncoded);
    } catch (e, stackTrace) {
      throw SaveStorageException(
        code: 'save_prefs_storage',
        message: 'Save Prefs Storage exception',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> clear() async {
    try {
      await prefs.clear();
    } catch (e, stackTrace) {
      throw ClearStorageException(
        code: 'clear_prefs_storage',
        message: 'Clear Prefs storage exception',
        stackTrace: stackTrace,
      );
    }
  }
}
