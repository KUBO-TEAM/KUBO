import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/data/models/recipe_model.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'dart:ui';

import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';

class RecipeScheduleModel extends RecipeSchedule {
  RecipeScheduleModel({
    required Recipe recipe,
    required DateTime start,
    required DateTime end,
    required int notificationStartId,
    Color? color,
    bool? isAllDay,
    required DateTime createdAt,
  }) : super(
          recipe: recipe,
          start: start,
          end: end,
          color: color,
          isAllDay: isAllDay,
          createdAt: createdAt,
          notificationStartId: notificationStartId,
        );

  factory RecipeScheduleModel.fromJson(Map<String, dynamic> json) {
    return RecipeScheduleModel(
      recipe: RecipeModel.fromJson(json['recipe']),
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
      createdAt: DateTime.parse(json['createdAt']),
      color: json['color'] ?? kGreenPrimary,
      isAllDay: json['isAllDay'] ?? false,
      notificationStartId: json['notificationStartId'],
    );
  }
}
