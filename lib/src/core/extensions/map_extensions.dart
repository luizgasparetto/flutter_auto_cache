extension MapValueUpdater<K extends Object, V> on Map<K, V> {
  void updateValue({required K key, required V data}) {
    if (this.containsKey(key)) {
      this[key] = data;
    }
  }
}
