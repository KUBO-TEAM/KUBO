import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';

part 'recipe_schedule.g.dart';

const kRecipeScheduleBoxKey = 'Recipe Schedule Box Key';

@HiveType(typeId: 0)
class RecipeSchedule extends HiveObject {
  @HiveField(0)
  Recipe recipe;

  @HiveField(1)
  DateTime start;

  @HiveField(2)
  DateTime end;

  @HiveField(3)
  Color? color;

  @HiveField(4)
  bool? isAllDay;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  int notificationStartId;

  RecipeSchedule({
    required this.recipe,
    required this.start,
    required this.end,
    required this.notificationStartId,
    this.color,
    this.isAllDay,
    required this.createdAt,
  });
}
