import 'package:shared_preferences/shared_preferences.dart';

import '../i_key_value_storage_service.dart';

class SharedPreferencesKeyValueStorageService
    implements IKeyValueStorageService {
  final SharedPreferences prefs;

  const SharedPreferencesKeyValueStorageService(this.prefs);

  @override
  T? get<T>({required String key}) {
    final retriveMethod = switch (T.runtimeType) {
      String => prefs.getString(key),
      int => prefs.getInt(key),
      double => prefs.getDouble(key),
      bool => prefs.getBool(key),
      _ => prefs.get(key),
    };

    return retriveMethod as T?;
  }

  @override
  Future<void> save<T>({required String key, required T value}) async {
    await switch (T.runtimeType) {
      String => prefs.setString(key, value as String),
      int => prefs.setInt(key, value as int),
      double => prefs.setDouble(key, value as double),
      bool => prefs.setBool(key, value as bool),
      _ => prefs.setString(key, value as String),
    };
  }
}
