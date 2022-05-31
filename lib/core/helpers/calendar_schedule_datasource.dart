import 'package:flutter/material.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderScheduleDataSource extends CalendarDataSource<RecipeSchedule> {
  CalenderScheduleDataSource(List<RecipeSchedule>? source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].start;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].end;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return appointments![index].recipe.name;
  }

  @override
  Color getColor(int index) {
    return appointments![index].color;
  }

  @override
  RecipeSchedule? convertAppointmentToObject(
      RecipeSchedule customData, Appointment appointment) {
    customData.start = appointment.startTime;
    customData.end = appointment.endTime;

    customData.save();
    return customData;
  }
}
