import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:kubo/core/constants/list_costants.dart';
import 'package:kubo/core/constants/string_constants.dart';
import 'package:kubo/core/hive/objects/schedule.hive.dart';
import 'package:kubo/core/temp/recipe.dart';
import 'package:kubo/core/temp/schedule.model.dart';

@lazySingleton
class LocalStorageService {
  dynamic scheduleBox;

  Future<dynamic> fetchSchedules() async {
    scheduleBox = await Hive.openBox(kScheduleBox);

    if (scheduleBox.isEmpty == false) {
      return scheduleBox;
    }

    return null;
  }

  void updateAndReturnSchedule({
    required ScheduleHive schedule,
    required Recipe recipe,
    required TimeOfDay start,
    required TimeOfDay end,
    required int day,
    required Color colorPicked,
  }) {
    final today = DateTime.now();

    final todayWeekday = DateFormat('EEEE').format(today);
    final indexTodayWeekDay = kDayList.indexOf(todayWeekday);
    final scheduleDay = today.day + (day - indexTodayWeekDay);

    schedule.startTime = DateTime(
      today.year,
      today.month,
      scheduleDay,
      start.hour,
      start.minute,
    );

    schedule.endTime = DateTime(
      today.year,
      today.month,
      scheduleDay,
      end.hour,
      end.minute,
    );

    schedule.color = colorPicked;

    schedule.save();
  }

  Schedule addAndReturnSchedule({
    required Recipe recipe,
    required TimeOfDay start,
    required TimeOfDay end,
    required int day,
    required Color colorPicked,
  }) {
    final today = DateTime.now();

    final todayWeekday = DateFormat('EEEE').format(today);
    final indexTodayWeekDay = kDayList.indexOf(todayWeekday);
    final scheduleDay = today.day + (day - indexTodayWeekDay);

    final startTime = DateTime(
      today.year,
      today.month,
      scheduleDay,
      start.hour,
      start.minute,
    );

    final endTime = DateTime(
      today.year,
      today.month,
      scheduleDay,
      end.hour,
      end.minute,
    );

    ScheduleHive newSchedule = ScheduleHive(
      recipeId: recipe.id,
      recipeName: recipe.name,
      recipeDescription: recipe.description,
      recipeImageUrl: recipe.imageUrl,
      startTime: startTime,
      endTime: endTime,
      color: colorPicked,
    );

    scheduleBox!.put(recipe.id, newSchedule);

    return Schedule(
      recipeId: recipe.id,
      recipeName: recipe.name,
      recipeDescription: recipe.description,
      recipeImageUrl: recipe.imageUrl,
      start: startTime,
      end: endTime,
      backgroundColor: colorPicked,
    );
  }
}
