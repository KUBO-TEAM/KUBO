import 'package:flutter/material.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';

class RecipeScheduleModel extends RecipeSchedule {
  RecipeScheduleModel({
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
}
