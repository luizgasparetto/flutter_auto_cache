abstract interface class IPrefsService {
  Map<String, dynamic>? get({required String key});
  Future<void> save({required String key, required Map<String, dynamic> data});
  Future<void> clear();
}
