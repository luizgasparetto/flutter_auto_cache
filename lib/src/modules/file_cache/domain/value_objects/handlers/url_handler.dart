import '../../../../../core/shared/errors/auto_cache_error.dart';
import '../../../../../core/shared/functional/either.dart';

abstract class UrlHandler {
  UrlHandler? nextHandler;

  void setNext(UrlHandler handler) => nextHandler = handler;

  Either<AutoCacheFailure, Unit> handle(String url);
}
