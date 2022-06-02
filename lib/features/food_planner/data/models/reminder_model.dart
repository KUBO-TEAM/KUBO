import 'package:kubo/features/food_planner/data/models/recipe_schedule_model.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/entities/reminder.dart';

class ReminderModel extends Reminder {
  const ReminderModel({
    required String title,
    required String message,
    required DateTime createdAt,
    required RecipeSchedule? recipeSchedule,
    required String? recipeId,
  }) : super(
          title: title,
          message: message,
          recipeId: recipeId,
          recipeSchedule: recipeSchedule,
          createdAt: createdAt,
        );

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      title: json['title'],
      message: json['message'],
      recipeId: json['recipe_id'],
      recipeSchedule: json['recipeSchedule'] == null
          ? null
          : RecipeScheduleModel.fromJson(json['recipeSchedule']),
      createdAt: DateTime.parse(json['createdAt'].toString()),
    );
  }
}
