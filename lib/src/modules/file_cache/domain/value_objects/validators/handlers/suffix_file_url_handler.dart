import '../../../../../../core/shared/contracts/handlers/chain_handler.dart';
import '../../../../../../core/shared/errors/auto_cache_error.dart';
import '../../../../../../core/shared/functional/either.dart';

import '../../../enums/file_types.dart';
import '../../../failures/url_failures.dart';

final class SuffixFileUrlHandler extends SyncChainHandler<Unit> {
  @override
  Either<AutoCacheFailure, Unit> handle(String url) {
    final extensions = FileTypes.values.map((file) => file.name).toList();
    final fileExtension = url.split('/').last.split('.').last.toLowerCase();

    final hasMatch = extensions.contains(fileExtension);

    if (hasMatch) return nextHandler?.handle(url) ?? right(unit);

    return left(InvalidUrlSuffixFileFailure());
  }
}
