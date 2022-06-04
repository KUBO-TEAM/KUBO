import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/features/food_planner/data/models/reminder_model.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/entities/reminder.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_recipe_schedule_reminder.dart';

abstract class ReminderLocalDataSource {
  /// fetch [ReminderModel] in Local
  ///
  /// Throws [ServerException] if no Local data is present.
  ///
  Future<List<Reminder>> fetchLocalReminders();
  Future<CreateRecipeScheduleReminderResponse> createRecipeScheduleReminder(
    RecipeSchedule recipeSchedule,
  );
}

@LazySingleton(as: ReminderLocalDataSource)
class ReminderLocalDataSourceImpl implements ReminderLocalDataSource {
  final Box<Reminder> reminderBox;

  ReminderLocalDataSourceImpl({
    required this.reminderBox,
  });

  @override
  Future<CreateRecipeScheduleReminderResponse> createRecipeScheduleReminder(
    RecipeSchedule recipeSchedule,
  ) async {
    final recipeScheduleModel = Reminder(
      title: 'Time to prepare! ',
      message: 'Please check this',
      createdAt: recipeSchedule.start,
      recipeSchedule: recipeSchedule,
    );

    // ${recipeSchedule.recipe.name} \n ${DateFormat.jm().format(recipeSchedule.start)} - ${DateFormat.jm().format(recipeSchedule.end)} ${DateFormat.yMMMEd('en_US').format(recipeSchedule.start)}

    reminderBox.add(recipeScheduleModel);

    return const CreateRecipeScheduleReminderResponse(
      message: 'Successfully create reminder',
    );
  }

  @override
  Future<List<Reminder>> fetchLocalReminders() async {
    final reminders = reminderBox.values.toList();
    List<Reminder> filteredReminders = [];

    for (Reminder reminder in reminders) {
      if (reminder.createdAt.isBefore(DateTime.now())) {
        filteredReminders.add(reminder);
      }
    }

    return filteredReminders.reversed.toList();
  }
}
