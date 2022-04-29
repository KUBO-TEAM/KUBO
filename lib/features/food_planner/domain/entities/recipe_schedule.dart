import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

part 'recipe_schedule.g.dart';

@HiveType(typeId: 0)
class RecipeSchedule extends HiveObject {
  @HiveField(0)
  final String recipeId;

  @HiveField(1)
  final DateTime start;

  @HiveField(2)
  final DateTime end;

  @HiveField(3)
  final Color color;

  @HiveField(4)
  final bool isAllDay;

  RecipeSchedule({
    required this.recipeId,
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
