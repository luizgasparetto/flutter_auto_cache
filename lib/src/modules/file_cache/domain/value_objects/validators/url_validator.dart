import '../../../../../core/shared/errors/auto_cache_error.dart';
import '../../../../../core/shared/functional/either.dart';

import 'handlers/domain_url_handler.dart';
import 'handlers/protocol_url_handler.dart';
import 'handlers/suffix_file_url_handler.dart';

final class UrlValidator {
  static Either<AutoCacheFailure, Unit> validate(String url) {
    final suffixFileHandler = SuffixFileUrlHandler();
    final domainHandler = DomainUrlHandler()..setNext(suffixFileHandler);
    final protocolHandler = ProtocolUrlHandler()..setNext(domainHandler);

    return protocolHandler.handle(url);
  }
}
