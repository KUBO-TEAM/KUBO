import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/features/food_planner/data/datasources/recipe_schedule_local_data_source.dart';

part 'recipe_schedule.g.dart';

@module
abstract class RecipeScheduleBox {
  @preResolve
  Future<Box<RecipeSchedule>> get recipeSchedule =>
      Hive.openBox(kRecipeScheduleBoxKey);
}

@HiveType(typeId: 0)
class RecipeSchedule extends HiveObject {
  @HiveField(0)
  final String recipeId;

  @HiveField(1)
  String recipeName;

  @HiveField(2)
  DateTime start;

  @HiveField(3)
  DateTime end;

  @HiveField(4)
  Color color;

  @HiveField(5)
  bool isAllDay;

  RecipeSchedule({
    required this.recipeId,
    required this.recipeName,
    required this.start,
    required this.end,
    required this.color,
    required this.isAllDay,
  });
}
