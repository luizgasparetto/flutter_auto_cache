import '../../../../../../core/shared/contracts/handlers/chain_handler.dart';
import '../../../../../../core/shared/errors/auto_cache_error.dart';
import '../../../../../../core/shared/functional/either.dart';
import '../../../failures/url_failures.dart';

final class DomainUrlHandler extends SyncChainHandler<String> {
  @override
  Either<AutoCacheFailure, Unit> handle(String value) {
    final domainRegex = RegExp(r'(([a-zA-Z0-9$-_@.&+!*(),]|%[0-9a-fA-F]{2})+)');

    final hasMatch = domainRegex.hasMatch(value);
    if (hasMatch) return nextHandler?.handle(value) ?? right(unit);

    return left(InvalidUrlDomainFailure());
  }
}
