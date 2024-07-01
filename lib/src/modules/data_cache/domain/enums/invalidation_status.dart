/// An enumeration representing the status of a cache entity's validity.
///
/// This enum is used to determine whether a cached entity is still valid or has become invalid.
enum InvalidationStatus {
  /// The cache entity is still valid and can be used.
  valid,

  /// The cache entity has become invalid and should not be used.
  invalid,
}
