/// An extension on [Type] that provides utility methods for type checking.
extension TypeExtensions on Type {
  /// Checks if the type is a `List`.
  ///
  /// This method returns `true` if the type is a `List`, otherwise `false`.
  bool get isList {
    return this.toString().startsWith('List');
  }

  bool isSameType(Type type) => this == type;
}
