/// A mixin that combines the capabilities of both `_ICommandKVSService`
/// and `_IQueryKVSService`, providing a comprehensive interface for
/// key-value storage operations.
///
/// This mixin should be applied to classes that implement both command
/// and query operations for key-value storage.
mixin IKvsService on _ICommandKvsService, _IQueryKvsService {}

/// An abstract interface class that defines a contract for command operations on a key-value storage service.
abstract interface class _ICommandKvsService {
  /// Saves a single value associated with the provided key to the key-value storage.
  ///
  /// - [key]: A string representing the key under which the data will be stored.
  /// - [data]: A string representing the data to be stored.
  ///
  /// Returns a `Future` that completes when the operation is done.
  Future<void> save({required String key, required String data});

  /// Saves a list of values associated with the provided key to the key-value storage.
  ///
  /// - [key]: A string representing the key under which the list of data will be stored.
  /// - [data]: A list of strings representing the data to be stored.
  ///
  /// Returns a `Future` that completes when the operation is done.
  Future<void> saveList({required String key, required List<String> data});

  /// Deletes the value associated with the provided key from the key-value storage.
  ///
  /// - [key]: A string representing the key whose data is to be deleted.
  ///
  /// Returns a `Future` that completes when the operation is done.
  Future<void> delete({required String key});

  /// Clears all key-value pairs from the storage.
  ///
  /// Returns a `Future` that completes when the operation is done.
  Future<void> clear();
}

/// An abstract interface class that defines a contract for querying a key-value storage service.
abstract interface class _IQueryKvsService {
  /// Retrieves a single value associated with the provided key from the key-value storage.
  ///
  /// - [key]: A string representing the key whose value is to be fetched.
  ///
  /// Returns the value associated with the specified key as a `String`.
  /// If the key does not exist, returns `null`.
  String? get({required String key});

  /// Retrieves a list of values associated with the provided key from the key-value storage.
  ///
  /// - [key]: A string representing the key whose list of values is to be fetched.
  ///
  /// Returns the list of values associated with the specified key as a `List<String>`.
  /// If the key does not exist, returns `null`.
  List<String>? getList({required String key});

  /// Retrieves all keys stored in the key-value storage.
  ///
  /// Returns a list of all keys as `List<String>`.
  List<String> getKeys();
}
