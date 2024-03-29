import 'package:auto_cache_manager/src/modules/data_cache/domain/constants/cache_size_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should be able to verify values of cache size constants', () {
    expect(CacheSizeConstants.defaultMaxKb, equals(0));
    expect(CacheSizeConstants.defaultMaxMb, equals(40));
    expect(CacheSizeConstants.bytesPerKb, equals(1024));
    expect(CacheSizeConstants.bytesPerMb, equals(1024 * 1024));
  });
}
