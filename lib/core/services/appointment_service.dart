import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:kubo/constants/list.costants.dart';
import 'package:kubo/constants/string.constants.dart';
import 'package:kubo/core/models/schedule.hive.dart';
import 'package:kubo/modules/meal_plan/models/recipe.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentService {
  dynamic scheduleBox;

  Future<dynamic> fetchAppointments() async {
    scheduleBox = await Hive.openBox(kScheduleBox);

    if (scheduleBox.isEmpty == false) {
      return scheduleBox;
    }

    return null;
  }

  void updateAndReturnAppointment({
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

  Appointment addAndReturnAppointment({
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
      recipeId: recipe.name,
      recipeName: recipe.name,
      startTime: startTime,
      endTime: endTime,
      color: colorPicked,
    );

    scheduleBox!.put(recipe.id, newSchedule);

    return Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: recipe.name,
      color: colorPicked,
    );
  }
}
