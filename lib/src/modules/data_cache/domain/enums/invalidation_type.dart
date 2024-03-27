///List of available invalidation methods to use in cache, which one has his own purporse and need to be learned until you used.
enum InvalidationType {
  ///The content is replaced with a new version fetched from the application.
  ///Refresh is the default invalidation type, this means that if you just use this, your cache data will always be replaced
  refresh,

  ///TTL is an acronymus for Time-To-Live.
  ///Maximum lifetime of some content.
  ///Expressed in either an expiry date for the content
  ttl,
}
