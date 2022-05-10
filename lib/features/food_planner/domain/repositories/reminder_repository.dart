import 'package:dartz/dartz.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/features/food_planner/domain/entities/reminder.dart';

abstract class ReminderRepository {
  Future<Either<Failure, List<Reminder>>> fetchReminders();
}
