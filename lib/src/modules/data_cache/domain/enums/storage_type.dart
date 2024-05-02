///List of available storage types, which one has his own purporse and need to be learned until you used.
enum StorageType {
  ///SQL is used for more "detailed" data, if you wanna store some entity info, VO's info, etc.. this is the most recommended way.
  sql,

  /// Prefs (Key Value Store) it's used to store simple values. E.g: Token.
  /// For curious/simplicity purpose, when you use SharedPreferences you're using an Prefs, an Key-Value database (NoSQL).
  prefs;

  bool get isPrefs => this == StorageType.prefs;
}
