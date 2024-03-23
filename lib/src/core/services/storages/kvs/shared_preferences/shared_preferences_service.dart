import 'dart:convert';

import 'package:auto_cache_manager/src/core/services/cryptography/i_cryptography_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../auto_cache_manager.dart';

import '../../../../extensions/map_extensions.dart';
import '../../dtos/adapters/storage_dto_adapter.dart';
import '../../dtos/storage_dto.dart';
import '../../exceptions/storage_exceptions.dart';
import '../i_prefs_service.dart';

class SharedPreferencesService implements IPrefsService {
  final SharedPreferences prefs;
  final ICryptographyService cryptoService;

  const SharedPreferencesService(this.prefs, this.cryptoService);

  @override
  Future<StorageDTO<T>?> get<T extends Object>({required String key}) async {
    try {
      final config = AutoCacheManagerInitializer.I.config;

      final response = prefs.getString(key);

      if (response == null) return null;

      final decoded = jsonDecode(response);
      final mapResponse = Map<String, dynamic>.of(decoded);

      if (config.cryptographyEnabled) {
        final decrypted = await cryptoService.decrypt(mapResponse['data']);
        mapResponse.updateValue(key: 'data', data: decrypted);
      }

      return StorageDTOAdapter.fromJson<T>(mapResponse);
    } catch (e, stackTrace) {
      throw GetPrefsStorageException(stackTrace: stackTrace);
    }
  }

  @override
  Future<void> save<T extends Object>({required String key, required T data}) async {
    try {
      final dto = await _getSaveStorageDto(key: key, data: data);

      final dtoMap = StorageDTOAdapter.toJson(dto);
      final jsonEncoded = jsonEncode(dtoMap);

      await prefs.setString(key, jsonEncoded);
    } catch (e, stackTrace) {
      throw SavePrefsStorageException(stackTrace: stackTrace);
    }
  }

  @override
  Future<void> clear() async {
    await prefs.clear();
  }

  Future<StorageDTO<Object>> _getSaveStorageDto<T extends Object>({required String key, required T data}) async {
    final config = AutoCacheManagerInitializer.I.config;

    if (config.cryptographyEnabled) {
      final encrypted = await cryptoService.encrypt(data.toString());

      return StorageDTO<String>(
        id: key,
        data: encrypted,
        invalidationTypeCode: config.invalidationType.name,
        createdAt: DateTime.now(),
      );
    }

    return StorageDTO<T>(
      id: key,
      data: data,
      invalidationTypeCode: config.invalidationType.name,
      createdAt: DateTime.now(),
    );
  }
}
