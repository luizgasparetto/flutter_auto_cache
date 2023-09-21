enum InvalidationTypes {
  purge,
  refresh,
  ban,
  ttl;

  bool get isNotSubstitute => this != InvalidationTypes.purge;
}
