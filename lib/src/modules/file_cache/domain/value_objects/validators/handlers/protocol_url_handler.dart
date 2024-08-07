import '../../../../../../core/shared/contracts/handlers/chain_handler.dart';
import '../../../../../../core/shared/errors/auto_cache_error.dart';
import '../../../../../../core/shared/functional/either.dart';

import '../../../failures/url_failures.dart';

final class ProtocolUrlHandler extends SyncChainHandler<Unit> {
  @override
  Either<AutoCacheFailure, Unit> handle(String url) {
    final protocolRegex = RegExp(r'^(https?:\/\/)');
    final hasMatch = protocolRegex.hasMatch(url);
    if (hasMatch) return nextHandler?.handle(url) ?? right(unit);

    return left(InvalidUrlProtocolFailure());
  }
}
