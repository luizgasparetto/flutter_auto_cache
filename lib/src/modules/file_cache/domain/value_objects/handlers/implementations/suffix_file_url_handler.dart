import '../../../../../../core/shared/errors/auto_cache_error.dart';
import '../../../../../../core/shared/functional/either.dart';

import '../../../enums/file_extensions.dart';
import '../../../failures/url_failures.dart';
import '../url_handler.dart';

final class SuffixFileUrlHandler extends UrlHandler {
  @override
  Either<AutoCacheFailure, Unit> handle(String url) {
    final values = FileExtensions.values.map((file) => file.name).toList();
    final separatedFiles = values.join('|');

    final fileRegex = RegExp('\\.($separatedFiles)\$', caseSensitive: false);
    final hasMatch = fileRegex.hasMatch(url);

    if (hasMatch) return nextHandler?.handle(url) ?? right(unit);

    return left(InvalidUrlSuffixFileFailure());
  }
}
