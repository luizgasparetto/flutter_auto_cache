import '../configuration/constants/cache_size_constants.dart';

import 'double_extensions.dart';

extension MbStringExtension on String {
  double get mbUsed {
    return (this.codeUnits.length / CacheSizeConstants.bytesPerMb).roundToDecimal();
  }
}
