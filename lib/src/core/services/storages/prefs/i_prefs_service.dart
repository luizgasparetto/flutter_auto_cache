abstract interface class IPrefsService {
  String? get({required String key});
  List<String>? getList({required String key});

  List<String> getKeys();

  Future<void> save({required String key, required String data});
  Future<void> saveList({required String key, required List<String> data});

  Future<void> delete({required String key});
  Future<void> clear();
}
