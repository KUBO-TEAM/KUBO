import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/reminder.dart';
import 'package:kubo/features/food_planner/domain/repositories/reminder_repository.dart';

@lazySingleton
class FetchLocalReminders implements UseCase<List<Reminder>, NoParams> {
  final ReminderRepository repository;

  FetchLocalReminders(this.repository);

  @override
  Future<Either<Failure, List<Reminder>>> call(NoParams params) async {
    return await repository.fetchLocalReminders();
  }
}
