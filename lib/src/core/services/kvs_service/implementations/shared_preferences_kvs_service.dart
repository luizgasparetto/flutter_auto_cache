import 'package:auto_cache_manager/src/core/services/kvs_service/i_kvs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../exceptions/storage_exceptions.dart';

class SharedPreferencesKVSService implements IKVSService {
  final SharedPreferences prefs;

  const SharedPreferencesKVSService(this.prefs);

  @override
  String? get({required String key}) {
    try {
      return prefs.getString(key);
    } catch (exception, stackTrace) {
      throw GetStorageException(
        code: 'get_prefs_storage_exception',
        message: 'Get Prefs Storage exception',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  List<String>? getList({required String key}) {
    try {
      return prefs.getStringList(key);
    } catch (exception, stackTrace) {
      throw GetStorageException(
        code: 'get_list_prefs_storage_exception',
        message: 'Get List Prefs Storage exception',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  List<String> getKeys() {
    try {
      return prefs.getKeys().toList();
    } catch (exception, stackTrace) {
      throw GetStorageKeysException(
        code: 'get_keys_prefs_storage',
        message: 'Failed to get keys of Prefs',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> save({required String key, required String data}) async {
    try {
      await prefs.setString(key, data);
    } catch (exception, stackTrace) {
      throw SaveStorageException(
        code: 'save_prefs_storage',
        message: 'Save Prefs Storage exception',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> saveList({required String key, required List<String> data}) async {
    try {
      await prefs.setStringList(key, data);
    } catch (exception, stackTrace) {
      throw SaveStorageException(
        code: 'save_list_prefs_storage',
        message: 'Save List Prefs Storage exception',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> delete({required String key}) async {
    try {
      await prefs.remove(key);
    } catch (exception, stackTrace) {
      throw DeleteStorageException(
        code: 'delete_storage',
        message: 'Delete Prefs Storage exception',
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
