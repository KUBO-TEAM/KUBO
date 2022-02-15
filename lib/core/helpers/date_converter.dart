import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:kubo/core/constants/list_costants.dart';
import 'package:kubo/core/error/failures.dart';

class StartAndEndTimeOfDay extends Equatable {
  final DateTime start;
  final DateTime end;

  const StartAndEndTimeOfDay({required this.start, required this.end});

  @override
  List<Object?> get props => [start, end];
}

@lazySingleton
class DateConverter {
  Either<Failure, StartAndEndTimeOfDay> convertStartAndEndTimeOfDay({
    required int day,
    required TimeOfDay startTimeOfDay,
    required TimeOfDay endTimeOfDay,
  }) {
    try {
      final today = DateTime.now();

      final todayWeekday = DateFormat('EEEE').format(today);
      final indexTodayWeekDay = kDayList.indexOf(todayWeekday);
      final scheduleDay = today.day + (day - indexTodayWeekDay);

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

      return Right(StartAndEndTimeOfDay(start: start, end: end));
    } on Exception {
      return Left(DateConverterFailure());
    }
  }
}

class DateConverterFailure extends Failure {}
