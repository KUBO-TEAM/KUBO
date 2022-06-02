import 'package:dartz/dartz.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/entities/reminder.dart';
import 'package:kubo/features/food_planner/domain/entities/user.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_recipe_schedule_reminder.dart';

abstract class ReminderRepository {
  Future<Either<Failure, List<Reminder>>> fetchReminders(User user);
  Future<Either<Failure, List<Reminder>>> fetchLocalReminders();

  Future<Either<Failure, CreateRecipeScheduleReminderResponse>>
      createRecipeScheduleReminder(
    RecipeSchedule recipeSchedule,
  );
}
