import '../../shared/errors/auto_cache_error.dart';

final class UpdatedBeforeCreatedAtFailure extends AutoCacheFailure {
  UpdatedBeforeCreatedAtFailure() : super(code: 'updated_at_earlier', message: "The Updated At cannot be earlier than the Created At");
}

final class UsedBeforeCreatedAtFailure extends AutoCacheFailure {
  UsedBeforeCreatedAtFailure() : super(code: 'used_at_earlier', message: "The Used At cannot be earlier than the Created At");
}

final class EndBeforeCreatedAtFailure extends AutoCacheFailure {
  EndBeforeCreatedAtFailure() : super(code: 'end_at_earlier', message: "The End At cannot be earlier than the Created At");
}
