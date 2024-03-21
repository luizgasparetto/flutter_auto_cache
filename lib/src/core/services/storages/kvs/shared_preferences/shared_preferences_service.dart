import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../auto_cache_manager.dart';
import '../../dtos/adapters/storage_dto_adapter.dart';
import '../../dtos/storage_dto.dart';
import '../../exceptions/storage_exceptions.dart';
import '../i_prefs_service.dart';

class SharedPreferencesService implements IPrefsService {
  final SharedPreferences prefs;

  const SharedPreferencesService(this.prefs);

  @override
  StorageDTO<T>? get<T extends Object>({required String key}) {
    try {
      final response = prefs.getString(key);

      if (response == null) return null;

      final mapResponse = jsonDecode(response);
      return StorageDTOAdapter.fromJson<T>(mapResponse);
    } catch (e, stackTrace) {
      throw GetPREFSStorageException(stackTrace: stackTrace);
    }
  }

  @override
  Future<void> save<T extends Object>({required String key, required T data}) async {
    try {
      final config = AutoCacheManagerInitializer.I.config;

      final dto = StorageDTO<T>(
        id: key,
        data: data,
        invalidationTypeCode: config.invalidationType.name,
        createdAt: DateTime.now(),
      );

      final dtoMap = StorageDTOAdapter.toJson(dto);
      final jsonEncoded = jsonEncode(dtoMap);

      await prefs.setString(key, jsonEncoded);
    } catch (e, stackTrace) {
      throw SavePREFSStorageException(stackTrace: stackTrace);
    }
  }

  @override
  Future<void> clear() async {
    await prefs.clear();
  }
}
