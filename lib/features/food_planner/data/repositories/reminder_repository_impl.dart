import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/features/food_planner/data/datasources/reminder_local_data_source.dart';
import 'package:kubo/features/food_planner/data/datasources/reminder_remote_data_source.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/entities/reminder.dart';
import 'package:kubo/features/food_planner/domain/entities/user.dart';
import 'package:kubo/features/food_planner/domain/repositories/reminder_repository.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_recipe_schedule_reminder.dart';

@LazySingleton(as: ReminderRepository)
class ReminderRepositoryImpl implements ReminderRepository {
  final ReminderLocalDataSource reminderLocalDataSource;
  final ReminderRemoteDataSource reminderRemoteDataSource;

  ReminderRepositoryImpl({
    required this.reminderRemoteDataSource,
    required this.reminderLocalDataSource,
  });

  @override
  Future<Either<Failure, List<Reminder>>> fetchReminders(User user) async {
    try {
      final notifications = await reminderRemoteDataSource.fetchReminders(user);

      return Right(notifications);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Reminder>>> fetchLocalReminders() async {
    try {
      final notifications = await reminderLocalDataSource.fetchLocalReminders();

      return Right(notifications);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CreateRecipeScheduleReminderResponse>>
      createRecipeScheduleReminder(RecipeSchedule recipeSchedule) async {
    try {
      final response = await reminderLocalDataSource
          .createRecipeScheduleReminder(recipeSchedule);

      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
