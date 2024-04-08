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
/// - `lru`: Least Recently Used. The cache management system keeps track of
///   the usage of entries. The least recently used entry is replaced first.
/// - `lfu`: Least Frequently Used. This policy uses a counter to keep track
///   of the number of times an entry is accessed. The entry with the lowest
///   count is replaced first.
enum SubstitutionPolicies {
  /// Least Recently Used (LRU) policy.
  ///
  /// Under this policy, the cache management system keeps track of the order
  /// in which entries are accessed. When the cache is full and a new entry
  /// needs to be added, the least recently used entry (the one that has not
  /// been accessed for the longest time) is removed to make space.
  lru,

  /// Least Frequently Used (LFU) policy.
  ///
  /// This policy uses a counter to keep track of how many times each entry is
  /// accessed. When the cache is full and a new entry needs to be added, the
  /// entry with the lowest access count is removed. If multiple entries have
  /// the same lowest count, one of them is selected at random for removal.
  lfu,

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
