extension UpdateMapValueExtension<K extends Object, V> on Map<K, V> {
  /// Extension on `Map` to provide additional utility methods for Map operations.
  ///
  /// `MapUpdateValue` enriches the `Map` class with new capabilities, allowing for more
  /// fluent and convenient manipulations of map data. This extension aims to enhance
  /// the functionality of maps in Dart by introducing methods that are commonly needed
  /// but not present in the standard library.
  ///
  /// This extension is generic and can be used with any types of keys and values, making
  /// it a versatile tool for map manipulations across Dart applications.

  /// Updates the value for the given `key` with `newValue` and returns the map.
  ///
  /// This method updates the value associated with `key` to `newValue`. If the
  /// key does not exist in the map, it will add the key with the `newValue`.
  /// The method returns the updated map, allowing for chaining of updates.
  Map<K, V> updateValueByKey({required K key, required V newValue}) {
    this[key] = newValue;
    return this;
  }
}

extension UpdateMapKeyExtension<K extends Object, V> on Map<K, V> {
  /// Extension on `Map` to provide additional utility methods for Map operations.
  ///
  /// `MapUpdateKey` enriches the `Map` class with new capabilities, allowing for more
  /// fluent and convenient manipulations of map data. This extension aims to enhance
  /// the functionality of maps in Dart by introducing methods that are commonly needed
  /// but not present in the standard library.
  ///
  /// This extension is generic and can be used with any types of keys and values, making
  /// it a versatile tool for map manipulations across Dart applications.

  /// Updates the key in the map to `newKey` for the given `oldKey` and returns the map.
  ///
  /// This method locates the entry with `oldKey`, removes it, and adds a new entry
  /// with `newKey` and the value from the old entry. If `oldKey` is not found, the map
  /// remains unchanged. This method facilitates key updates and supports chaining of
  /// operations on the map.
  Map<K, V> updateKey({required K oldKey, required K newKey}) {
    if (this.containsKey(oldKey)) {
      final value = this[oldKey] as V;

      this.remove(oldKey);
      this[newKey] = value;
    }

    return this;
  }
}
