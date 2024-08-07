import 'dart:math';

import '../../../../../core/domain/services/substitution_service/cache_substitution_strategy.dart';
import '../../../../../core/shared/contracts/auto_cache_notifier.dart';
import '../../../../../core/shared/extensions/types/list_extensions.dart';
import '../../../../../core/shared/errors/auto_cache_error.dart';
import '../../../../../core/shared/functional/either.dart';

import '../../dtos/key_cache_dto.dart';
import '../../entities/data_cache_entity.dart';
import '../../repositories/i_data_cache_repository.dart';

part './strategies/fifo_substitution_cache_strategy.dart';
part './strategies/random_substitution_cache_strategy.dart';
part './strategies/lru_substitution_cache_strategy.dart';
part './strategies/mru_substitution_cache_strategy.dart';

sealed class IDataCacheSubstitutionStrategy extends ICacheSubstitutionStrategy {
  final IDataCacheRepository dataRepository;
  final ISubstitutionDataCacheRepository substitutionRepository;

  const IDataCacheSubstitutionStrategy(this.dataRepository, this.substitutionRepository);

  @override
  AsyncEither<AutoCacheError, Unit> delete({required String key}) async {
    return dataRepository.delete(KeyCacheDTO(key: key));
  }

  @override
  AsyncEither<AutoCacheException, bool> accomodate(covariant DataCacheEntity data, {required String key}) async {
    return substitutionRepository.accomodateCache(data, key: key);
  }
}
