import 'dart:core';

import 'package:meta/meta.dart';

import '../../../../core/shared/contracts/value_object.dart';
import '../../../../core/shared/errors/auto_cache_error.dart';

import '../../../../core/shared/functional/either.dart';

import 'validators/url_validator.dart';

@immutable
final class UrlDetails implements ValueObject {
  final String value;

  const UrlDetails(this.value);

  @override
  Either<AutoCacheFailure, Unit> validate() => UrlValidator.validate(value);

  String get fileName => value.split('/').last.split('.').first.toLowerCase();

  @override
  List<Object?> get props => [value];
}
