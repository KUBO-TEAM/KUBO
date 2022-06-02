import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:kubo/core/helpers/utils.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderScheduleDataSource extends CalendarDataSource<RecipeSchedule> {
  final BuildContext context;
  final List<RecipeSchedule>? recipeSchedules;
  CalenderScheduleDataSource({
    required this.recipeSchedules,
    required this.context,
  }) {
    appointments = recipeSchedules;
  }

  Future<void> callAlert() async {}

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
    int daysBetween = Utils.daysBetween(DateTime.now(), appointment.startTime);

    if (daysBetween >= 0 &&
        daysBetween < 7 &&
        Utils.hoursBetween(DateTime.now(), appointment.startTime) >= 0) {
      customData.start = appointment.startTime;
      customData.end = appointment.endTime;
      customData.save();
    } else {
      Future.delayed(const Duration(microseconds: 500), () {
        ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            title: "Oops...",
            text: "You can't schedule in the past, and above 1 week",
          ),
        );
      });
    }

    return customData;
  }
}
