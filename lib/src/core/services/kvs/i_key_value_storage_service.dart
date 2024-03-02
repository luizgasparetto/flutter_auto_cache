abstract interface class IKeyValueStorageService {
  T? get<T>({required String key});
  Future<void> save<T>({required String key, required T value});
}
