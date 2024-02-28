///List of available storage types, which one has his own purporse and need to be learned until you used.
///Checkout our docs to see more details about any of storage types at: https://go-search-yourself.com
enum StorageTypes {
  ///SQL is used for more "detailed" data, if you wanna store some entity info, VO's info, etc.. this is the most recommended way.
  sql,

  /// KVS (Key Value Store) it's used to store simple values. E.g: Token.
  /// For curious/simplicity purpose, when you use SharedPreferences you're using an KVS, an Key-Value database (NoSQL).
  kvs,
}
