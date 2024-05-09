extension TypeExtensions on Type {
  bool get isList {
    return this.toString().startsWith('List');
  }
}
