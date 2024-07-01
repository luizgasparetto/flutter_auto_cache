/// List of available invalidation methods to use in cache.
///
/// Each invalidation method has its own purpose and should be understood before use.
///
/// The invalidation methods are:
/// - `ttl`: Time-To-Live. Represents the maximum lifetime of some content,
///   expressed as an expiry date for the content.
enum InvalidationTypes {
  /// Time-To-Live (TTL) invalidation.
  ///
  /// Represents the maximum lifetime of some content. This can be expressed as an expiry date
  /// for the content, after which it is considered invalid and should be removed from the cache.
  ttl,
}
