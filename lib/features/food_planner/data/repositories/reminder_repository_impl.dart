import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/features/food_planner/data/datasources/reminder_remote_data_source.dart';
import 'package:kubo/features/food_planner/domain/entities/reminder.dart';
import 'package:kubo/features/food_planner/domain/repositories/reminder_repository.dart';

@LazySingleton(as: ReminderRepository)
class ReminderRepositoryImpl implements ReminderRepository {
  final ReminderRemoteDataSource reminderRemoteDataSource;

  ReminderRepositoryImpl(
    this.reminderRemoteDataSource,
  );

  @override
  Future<Either<Failure, List<Reminder>>> fetchReminders() async {
    try {
      final notifications = await reminderRemoteDataSource.fetchReminders();

      return Right(notifications);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
