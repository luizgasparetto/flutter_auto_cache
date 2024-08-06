import 'dart:core';

import 'package:meta/meta.dart';

import '../../../../core/shared/contracts/value_object.dart';
import '../../../../core/shared/errors/auto_cache_error.dart';

import '../../../../core/shared/functional/either.dart';
import '../../../../core/shared/functional/equals.dart';

import 'validators/url_validator.dart';

@immutable
final class UrlDetails extends Equals implements ValueObject {
  final String url;

  const UrlDetails(this.url);

  @override
  Either<AutoCacheFailure, Unit> validate() => UrlValidator.validate(url);

  String get fileName => url.split('/').last.split('.').first.toLowerCase();

  @override
  List<Object?> get props => [url];
}
