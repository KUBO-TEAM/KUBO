import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:kubo/core/constants/list_costants.dart';
import 'package:kubo/core/error/failures.dart';

class StartAndEndDateTime extends Equatable {
  final DateTime start;
  final DateTime end;

  const StartAndEndDateTime({required this.start, required this.end});

  @override
  List<Object?> get props => [start, end];
}

@lazySingleton
class DateConverter {
  Either<DateConverterFailure, StartAndEndDateTime>
      convertStartAndEndTimeOfDay({
    required String day,
    required TimeOfDay startTimeOfDay,
    required TimeOfDay endTimeOfDay,
  }) {
    try {
      final today = DateTime.now();

      final intDay = kDayList.indexOf(day);

      final todayWeekday = DateFormat('EEEE').format(today);
      final indexTodayWeekDay = kDayList.indexOf(todayWeekday);

      int diffIntDayAndTodayWeekday = intDay - indexTodayWeekDay;

      if (diffIntDayAndTodayWeekday < 0) {
        diffIntDayAndTodayWeekday = 7 + diffIntDayAndTodayWeekday;
      }

      final scheduleDay = today.day + diffIntDayAndTodayWeekday;

      final start = DateTime(
        today.year,
        today.month,
        scheduleDay,
        startTimeOfDay.hour,
        startTimeOfDay.minute,
      );

      final end = DateTime(
        today.year,
        today.month,
        scheduleDay,
        endTimeOfDay.hour,
        endTimeOfDay.minute,
      );

      return Right(StartAndEndDateTime(start: start, end: end));
    } on Exception {
      throw const Left(
        DateConverterFailure(
          message: 'Something went wrong converting dates',
        ),
      );
    }
  }
}

class DateConverterFailure extends Failure {
  final String message;

  const DateConverterFailure({
    required this.message,
  });
}
