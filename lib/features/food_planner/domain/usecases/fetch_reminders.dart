import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/reminder.dart';
import 'package:kubo/features/food_planner/domain/entities/user.dart';
import 'package:kubo/features/food_planner/domain/repositories/reminder_repository.dart';

@lazySingleton
class FetchReminders implements UseCase<List<Reminder>, User> {
  final ReminderRepository repository;

  FetchReminders(this.repository);

  @override
  Future<Either<Failure, List<Reminder>>> call(User user) async {
    return await repository.fetchReminders(user);
  }
}
