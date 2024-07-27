import 'package:shared_preferences/shared_preferences.dart';

import '../exceptions/kvs_storage_exceptions.dart';
import '../i_kvs_service.dart';

class SharedPreferencesKvsService implements IKvsService {
  final SharedPreferences prefs;

  const SharedPreferencesKvsService(this.prefs);

  @override
  String? get({required String key}) {
    try {
      return prefs.getString(key);
    } catch (exception, stackTrace) {
      throw GetKvsStorageException(
        message: 'An error occurred while getting data from storage: ${exception.toString()}',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  List<String>? getList({required String key}) {
    try {
      return prefs.getStringList(key);
    } catch (exception, stackTrace) {
      throw GetListKvsStorageException(
        message: 'An error occurred while retrieving storage keys: ${exception.toString()}',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  List<String> getKeys() {
    try {
      return prefs.getKeys().toList();
    } catch (exception, stackTrace) {
      throw GetKvsStorageKeysException(
        message: 'An error occurred while retrieving storage keys: ${exception.toString()}',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> save({required String key, required String data}) async {
    try {
      await prefs.setString(key, data);
    } catch (exception, stackTrace) {
      throw SaveKvsStorageException(
        message: 'An error occurred while saving data to storage: ${exception.toString()}',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> saveList({required String key, required List<String> data}) async {
    try {
      await prefs.setStringList(key, data);
    } catch (exception, stackTrace) {
      throw SaveListKvsStorageException(
        message: 'An error occurred while saving a list to storage: ${exception.toString()}',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> delete({required String key}) async {
    try {
      await prefs.remove(key);
    } catch (exception, stackTrace) {
      throw DeleteKvsStorageException(
        message: 'An error occurred while deleting data from storage: ${exception.toString()}',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> clear() async {
    try {
      await prefs.clear();
    } catch (exception, stackTrace) {
      throw ClearKvsStorageException(
        message: 'An error occurred while clearing all data from storage: ${exception.toString()}',
        stackTrace: stackTrace,
      );
    }
  }
}
