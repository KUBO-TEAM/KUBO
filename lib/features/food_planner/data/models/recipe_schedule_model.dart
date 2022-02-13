import 'package:flutter/material.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';

class RecipeScheduleModel extends RecipeSchedule {
  const RecipeScheduleModel({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required DateTime start,
    required DateTime end,
    required Color color,
    required bool isAllDay,
  }) : super(
          id: id,
          name: name,
          description: description,
          imageUrl: imageUrl,
          start: start,
          end: end,
          color: color,
          isAllDay: isAllDay,
        );
}
