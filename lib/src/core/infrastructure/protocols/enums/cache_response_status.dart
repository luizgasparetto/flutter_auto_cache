enum CacheResponseStatus {
  success('success'),
  notFound('not_found'),
  expired('expired');

  final String status;

  const CacheResponseStatus(this.status);
}
