import '../../../../core/shared/errors/auto_cache_error.dart';

final class InvalidUrlProtocolFailure extends AutoCacheFailure {
  InvalidUrlProtocolFailure() : super(code: 'invalid_url_protocol', message: 'Invalid URL protocol. Must be either HTTP or HTTPS.');
}

final class InvalidUrlDomainFailure extends AutoCacheFailure {
  InvalidUrlDomainFailure() : super(code: 'invalid_url_domain', message: 'Invalid URL domain. Domain must be valid and not empty.');
}

final class InvalidUrlSuffixFileFailure extends AutoCacheFailure {
  InvalidUrlSuffixFileFailure() : super(code: 'invalid_url_suffix_file', message: 'Invalid URL suffix. File extension must be valid.');
}
