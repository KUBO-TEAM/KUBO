import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

part 'schedule.hive.g.dart';

@HiveType(typeId: 0)
class ScheduleHive extends HiveObject {
  @HiveField(0)
  String recipeId;

  @HiveField(1)
  String recipeName;

  @HiveField(2)
  DateTime startTime;

  @HiveField(3)
  DateTime endTime;

  @HiveField(4)
  Color color;

  ScheduleHive({
    required this.recipeId,
    required this.recipeName,
    required this.startTime,
    required this.endTime,
    required this.color,
  });
}
