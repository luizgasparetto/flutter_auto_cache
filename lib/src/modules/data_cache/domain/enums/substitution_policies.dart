/// Represents the substitution policies available for cache management.
///
/// These policies determine how items in a cache are replaced when the cache
/// reaches its capacity and a new item needs to be added. Each policy has
/// its own strategy for selecting which item to remove from the cache.
///
/// The policies are:
/// - `fifo`: First In, First Out. Entries are removed in the same order they
///   were added, akin to a queue.
/// - `random`: A random entry is selected for removal. This policy does not
///   necessarily consider the use or order of entries.
enum SubstitutionPolicies {
  /// First In, First Out (FIFO) policy.
  ///
  /// Entries are removed in the same order they were added, akin to a queue.
  /// This means that the oldest entry (the first one that was added and has not
  /// yet been removed) is the first to be removed when making space for a new entry.
  fifo,

  /// Random replacement policy.
  ///
  /// A random entry is selected for removal without considering the order of
  /// entries or how frequently they have been accessed. This policy is the
  /// simplest in terms of implementation and computational overhead but may
  /// not always provide the best performance in terms of cache hit rate.
  random
}
