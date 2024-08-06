import '../../core/shared/contracts/modules/package_module.dart';
import '../../core/shared/services/service_locator/implementations/service_locator.dart';

import '../../core/shared/controllers/token_bucket/token_bucket_controller.dart';

final class FileCacheModule extends CacheModule {
  @override
  Future<void> registerBinds() async {
    ServiceLocator.instance.bindFactory<ITokenBucketController>(() => TokenBucketController());
  }
}
