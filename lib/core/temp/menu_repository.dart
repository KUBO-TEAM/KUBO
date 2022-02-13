import 'package:flutter/material.dart';
import 'package:kubo/core/hive/objects/schedule.hive.dart';
import 'package:kubo/core/temp/local_storage_service.dart';
import 'package:kubo/core/temp/recipe.dart';
import 'package:kubo/core/temp/schedule.model.dart';

class MenuRepository {
  final LocalStorageService localStorageService;

  MenuRepository({required this.localStorageService});

  Future<dynamic> fetchSchedules() async {
    final schedules = await localStorageService.fetchSchedules();
    return schedules;
  }

  Schedule addAndReturnSchedule({
    required Recipe recipe,
    required TimeOfDay start,
    required TimeOfDay end,
    required int day,
    required Color colorPicked,
  }) {
    return localStorageService.addAndReturnSchedule(
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
    localStorageService.updateAndReturnSchedule(
      schedule: schedule,
      recipe: recipe,
      start: start,
      end: end,
      day: day,
      colorPicked: colorPicked,
    );
  }
}
