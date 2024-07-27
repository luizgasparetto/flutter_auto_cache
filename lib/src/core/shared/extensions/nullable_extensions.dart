/// Extension that provides a `let` function for nullable types.
///
/// This extension allows you to perform operations on a nullable value
/// only if it is not null. The result of the operation is also nullable.
///
/// This is similar to the `let` function in Kotlin.
extension NullableLetExtension<T extends Object> on T? {
  /// Executes the given function [op] if the value is not null,
  /// and returns the result of the function. If the value is null,
  /// returns null.
  ///
  /// - Parameter op: The function to execute if the value is not null.
  /// - Returns: The result of the function [op] if the value is not null, otherwise null.
  R? let<R>(R Function(T) op) => this == null ? null : op(this as T);
}
