import '../../../../../../core/shared/errors/auto_cache_error.dart';
import '../../../../../../core/shared/functional/either.dart';

import '../../../failures/url_failures.dart';
import '../url_handler.dart';

final class DomainUrlHandler extends UrlHandler {
  @override
  Either<AutoCacheFailure, Unit> handle(String url) {
    final domainRegex = RegExp(r'(([a-zA-Z0-9$-_@.&+!*(),]|%[0-9a-fA-F]{2})+)');
    final hasMatch = domainRegex.hasMatch(url);

    if (hasMatch) return nextHandler?.handle(url) ?? right(unit);

    return left(InvalidUrlDomainFailure());
  }
}
