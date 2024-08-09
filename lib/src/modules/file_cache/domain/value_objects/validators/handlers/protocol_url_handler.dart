import '../../../../../../core/shared/contracts/handlers/chain_handler.dart';
import '../../../../../../core/shared/errors/auto_cache_error.dart';
import '../../../../../../core/shared/functional/either.dart';

import '../../../failures/url_failures.dart';

final class ProtocolUrlHandler extends SyncChainHandler<Unit, String> {
  @override
  Either<AutoCacheFailure, Unit> handle(String value) {
    final protocolRegex = RegExp(r'^(https?:\/\/)');

    final hasMatch = protocolRegex.hasMatch(value);
    if (hasMatch) return nextHandler?.handle(value) ?? right(unit);

    return left(InvalidUrlProtocolFailure());
  }
}
