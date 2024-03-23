import '../dtos/storage_dto.dart';

abstract interface class IPrefsService {
  Future<StorageDTO<T>?> get<T extends Object>({required String key});
  Future<void> save<T extends Object>({required String key, required T data});
  Future<void> clear();
}
