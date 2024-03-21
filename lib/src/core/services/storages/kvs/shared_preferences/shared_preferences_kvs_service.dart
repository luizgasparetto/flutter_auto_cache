import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../auto_cache_manager.dart';
import '../../dtos/adapters/storage_dto_adapter.dart';
import '../../dtos/storage_dto.dart';
import '../../exceptions/storage_exceptions.dart';
import '../i_key_value_storage_service.dart';

class SharedPreferencesKeyValueStorageService implements IKeyValueStorageService {
  final SharedPreferences prefs;

  const SharedPreferencesKeyValueStorageService(this.prefs);

  @override
  StorageDTO<T>? get<T extends Object>({required String key}) {
    try {
      final response = prefs.getString(key);

      if (response == null) return null;

      final mapResponse = jsonDecode(response);
      return StorageDTOAdapter.fromJson<T>(mapResponse);
    } catch (e, stackTrace) {
      throw GetKVSStorageException(stackTrace: stackTrace);
    }
  }

  @override
  Future<void> save<T extends Object>({required String key, required T data}) async {
    try {
      final config = AutoCacheManagerInitialazer.I.config;

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
      throw SaveKVSStorageException(stackTrace: stackTrace);
    }
  }

  @override
  Future<void> clear() async {
    await prefs.clear();
  }
}
