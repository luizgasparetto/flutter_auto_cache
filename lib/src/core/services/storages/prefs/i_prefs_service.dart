abstract interface class IPrefsService {
  String? get({required String key});
  List<String> getKeys();

  Future<void> save({required String key, required String data});
  Future<void> delete({required String key});
  Future<void> clear();
}
