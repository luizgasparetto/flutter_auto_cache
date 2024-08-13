import 'package:shared_preferences/shared_preferences.dart';

import '../exceptions/storage_storage_exceptions.dart';
import '../i_storage_service.dart';

class SharedPreferencesStorageService implements IStorageService {
  final SharedPreferences prefs;

  const SharedPreferencesStorageService(this.prefs);

  @override
  String? get({required String key}) {
    try {
      return prefs.getString(key);
    } catch (exception, stackTrace) {
      throw GetStorageStorageException(
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
      throw GetListStorageStorageException(
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
      throw GetStorageStorageKeysException(
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
      throw SaveStorageStorageException(
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
      throw SaveListStorageStorageException(
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
      throw DeleteStorageStorageException(
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
      throw ClearStorageStorageException(
        message: 'An error occurred while clearing all data from storage: ${exception.toString()}',
        stackTrace: stackTrace,
      );
    }
  }
}
