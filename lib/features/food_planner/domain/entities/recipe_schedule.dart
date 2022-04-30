import 'package:equatable/equatable.dart';
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
class RecipeSchedule extends Equatable {
  @HiveField(0)
  final String recipeId;

  @HiveField(1)
  final String recipeName;

  @HiveField(2)
  final DateTime start;

  @HiveField(3)
  final DateTime end;

  @HiveField(4)
  final Color color;

  @HiveField(5)
  final bool isAllDay;

  const RecipeSchedule({
    required this.recipeId,
    required this.recipeName,
    required this.start,
    required this.end,
    required this.color,
    required this.isAllDay,
  });

  @override
  List<Object?> get props => [
        recipeId,
        start,
        end,
        color,
        isAllDay,
      ];
}
