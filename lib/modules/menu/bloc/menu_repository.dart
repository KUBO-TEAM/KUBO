import 'package:flutter/material.dart';
import 'package:kubo/core/models/schedule.hive.dart';
import 'package:kubo/core/services/schedule_service.dart';
import 'package:kubo/modules/meal_plan/models/recipe.dart';
import 'package:kubo/modules/menu/models/schedule.model.dart';

class MenuRepository {
  final ScheduleService scheduleService;

  MenuRepository({required this.scheduleService});

  Future<dynamic> fetchSchedules() async {
    final appointments = await scheduleService.fetchSchedules();
    return appointments;
  }

  Schedule addAndReturnSchedule({
    required Recipe recipe,
    required TimeOfDay start,
    required TimeOfDay end,
    required int day,
    required Color colorPicked,
  }) {
    return scheduleService.addAndReturnSchedule(
      recipe: recipe,
      start: start,
      end: end,
      day: day,
      colorPicked: colorPicked,
    );
  }

  void updateAndReturnSchedule({
    required ScheduleHive schedule,
    required Recipe recipe,
    required TimeOfDay start,
    required TimeOfDay end,
    required int day,
    required Color colorPicked,
  }) {
    scheduleService.updateAndReturnSchedule(
      schedule: schedule,
      recipe: recipe,
      start: start,
      end: end,
      day: day,
      colorPicked: colorPicked,
    );
  }
}
