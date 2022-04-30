import 'package:flutter/material.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';

class RecipeScheduleModel extends RecipeSchedule {
  const RecipeScheduleModel({
    required String recipeId,
    required DateTime start,
    required DateTime end,
    required Color color,
    required bool isAllDay,
  }) : super(
          recipeId: recipeId,
          start: start,
          end: end,
          color: color,
          isAllDay: isAllDay,
        );

  factory RecipeScheduleModel.fromHiveObject(RecipeSchedule recipeSchedule) {
    return RecipeScheduleModel(
      recipeId: recipeSchedule.recipeId,
      start: recipeSchedule.start,
      end: recipeSchedule.end,
      color: recipeSchedule.color,
      isAllDay: recipeSchedule.isAllDay,
    );
  }
}
