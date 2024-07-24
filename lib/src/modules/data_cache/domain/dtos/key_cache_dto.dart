class KeyCacheDTO {
  final String key;

  const KeyCacheDTO({required this.key});

  @override
  bool operator ==(covariant KeyCacheDTO other) {
    if (identical(this, other)) return true;

    return other.key == key;
  }

  @override
  int get hashCode => key.hashCode;
}
