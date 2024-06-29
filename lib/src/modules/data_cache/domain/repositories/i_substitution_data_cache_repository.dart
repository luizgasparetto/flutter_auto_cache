import '../../../../core/core.dart';
import '../entities/data_cache_entity.dart';

abstract interface class ISubstitutionDataCacheRepository {
  AsyncEither<AutoCacheError, Unit> updateCacheUsage<T extends Object>(DataCacheEntity<T> cache);
}




abstract interface class AAAAAAAA {
  AsyncEither<AutoCacheError, Unit> getRecentUsed
  AsyncEither<AutoCacheError, Unit> updateCacheUsage<T extends Object>(DataCacheEntity<T> cache);
}



// void main() {


//  final a = { "substitution-key-${DateTime.now().millisecondsSinceEpoch}": "aaaaa"};
// }