import '../../../../../core/errors/auto_cache_error.dart';

sealed class DataCacheAdapterException extends AutoCacheException {
  DataCacheAdapterException({
    required super.message,
    required super.code,
    required super.stackTrace,
  });
}

class DataCacheTypeException<T> extends DataCacheAdapterException {
  DataCacheTypeException({
    required Type type,
    required super.stackTrace,
  }) : super(code: 'data_cache_type', message: 'An error occurred while parsing the data of type <$type>. The requested type is <$T>.');
}

class DataCacheFromJsonException extends DataCacheAdapterException {
  DataCacheFromJsonException({
    required Object exception,
    required super.stackTrace,
  }) : super(code: 'data_cache_from_json', message: 'An error occurred while parsing from json: ${exception.toString()}');
}

class DataCacheListFromJsonException extends DataCacheAdapterException {
  DataCacheListFromJsonException({
    required Object exception,
    required super.stackTrace,
  }) : super(code: 'data_cache_list_from_json', message: 'An error occurred while parsing a list from json: ${exception.toString()}');
}
