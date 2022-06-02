import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';

part 'reminder.g.dart';

const kReminderBoxKey = 'Reminder Box Key';

@HiveType(typeId: 7)
class Reminder extends Equatable {
  const Reminder({
    this.recipeId,
    required this.title,
    required this.message,
    this.recipeSchedule,
    required this.createdAt,
  });

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String message;

  @HiveField(3)
  final String? recipeId;

  @HiveField(4)
  final RecipeSchedule? recipeSchedule;

  @HiveField(5)
  final DateTime createdAt;

  @override
  List<Object?> get props => [
        title,
        message,
        recipeId,
        recipeSchedule,
        createdAt,
      ];
}
