// ignore_for_file: constant_identifier_names

import 'package:kubo/core/helpers/date_converter.dart';

import 'failures.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE =
    'Cache Failure probably no data on the cache.';
const String DATE_CONVERTER_FAILURE_MESSAGE = 'Date Converter Failure';
const String UNEXPECTED_FAILURE_MESSAGE = 'Unexpected Failure';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    case DateConverterFailure:
      return DATE_CONVERTER_FAILURE_MESSAGE;
    default:
      return UNEXPECTED_FAILURE_MESSAGE;
  }
}
