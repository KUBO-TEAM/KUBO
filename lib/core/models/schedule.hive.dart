import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

@HiveType(typeId: 0)
class ScheduleHive extends HiveObject {
  @HiveField(0)
  String? recipeName;

  @HiveField(1)
  String? scheduledDay;

  @HiveField(2)
  TimeOfDay? startingTime;

  @HiveField(3)
  TimeOfDay? endingTime;
}
