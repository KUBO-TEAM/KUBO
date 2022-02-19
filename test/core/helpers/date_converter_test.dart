import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kubo/core/helpers/date_converter.dart';

import '../../test_constants.dart';

void main() {
  late DateConverter dateConverter;

  setUp(() {
    dateConverter = DateConverter();
  });

  const startTimeOfDay = TimeOfDay(hour: 12, minute: 0);
  const endTimeOfDay = TimeOfDay(hour: 13, minute: 0);
  group('convertStartAndEndTimeOfDay', () {
    test('should return StartAndEndTimeOfDay if the conversion is successfull',
        () async {
      final result = dateConverter.convertStartAndEndTimeOfDay(
        day: tDay,
        startTimeOfDay: startTimeOfDay,
        endTimeOfDay: endTimeOfDay,
      );

      expect(
        result,
        equals(
          Right(
            StartAndEndDateTime(
              start: tStart,
              end: tEnd,
            ),
          ),
        ),
      );
    });
  });
}
