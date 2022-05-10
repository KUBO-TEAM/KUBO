import 'package:kubo/features/food_planner/domain/entities/reminder.dart';

class ReminderModel extends Reminder {
  const ReminderModel({
    required String title,
    required String message,
    required String? recipeId,
  }) : super(
          title: title,
          message: message,
          recipeId: recipeId,
        );

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      title: json['title'],
      message: json['message'],
      recipeId: json['recipe_id'],
    );
  }
}
