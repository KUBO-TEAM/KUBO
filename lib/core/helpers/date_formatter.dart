import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kubo/core/constants/list_costants.dart';

DateTime convertTimeOfDay({
  required int day,
  required TimeOfDay timeOfDay,
}) {
  final today = DateTime.now();

  final todayWeekday = DateFormat('EEEE').format(today);
  final indexTodayWeekDay = kDayList.indexOf(todayWeekday);
  final scheduleDay = today.day + (day - indexTodayWeekDay);

  return DateTime(
    today.year,
    today.month,
    scheduleDay,
    timeOfDay.hour,
    timeOfDay.minute,
  );
}
