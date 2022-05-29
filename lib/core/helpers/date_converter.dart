import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/core/helpers/utils.dart';

class StartAndEndDateTime extends Equatable {
  final DateTime start;
  final DateTime end;

  const StartAndEndDateTime({required this.start, required this.end});

  @override
  List<Object?> get props => [start, end];
}

@lazySingleton
class DateConverter {
  Either<Failure, StartAndEndDateTime> convertStartAndEndTimeOfDay({
    required String day,
    required TimeOfDay startTimeOfDay,
    required TimeOfDay endTimeOfDay,
  }) {
    try {
      return Right(
        Utils.convertStartAndEndTimeOfDay(
          day: day,
          startTimeOfDay: startTimeOfDay,
          endTimeOfDay: endTimeOfDay,
        ),
      );
    } on Exception {
      return Left(DateConverterFailure());
    }
  }
}

class DateConverterFailure extends Failure {}
