import '../../../../../core/shared/errors/auto_cache_error.dart';
import '../../../../../core/shared/functional/either.dart';
import '../handlers/implementations/domain_url_handler.dart';
import '../handlers/implementations/protocol_url_handler.dart';

final class UrlValidator {
  static Either<AutoCacheFailure, Unit> validate(String url) {
    final domainHandler = DomainUrlHandler();
    final protocolHandler = ProtocolUrlHandler()..setNext(domainHandler);

    return protocolHandler.handle(url);
  }
}
