import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'schedule.hive.g.dart';

@HiveType(typeId: 0)
class ScheduleHive extends HiveObject {
  @HiveField(0)
  String recipeId;

  @HiveField(1)
  String recipeName;

  @HiveField(2)
  String recipeDescription;

  @HiveField(3)
  String recipeImageUrl;

  @HiveField(4)
  DateTime startTime;

  @HiveField(5)
  DateTime endTime;

  @HiveField(6)
  Color color;

  ScheduleHive({
    required this.recipeId,
    required this.recipeName,
    required this.recipeDescription,
    required this.recipeImageUrl,
    required this.startTime,
    required this.endTime,
    required this.color,
  });
}
