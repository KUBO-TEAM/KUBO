import 'package:flutter/material.dart';
import 'package:kubo/core/models/schedule.hive.dart';
import 'package:kubo/core/services/appointment_service.dart';
import 'package:kubo/modules/meal_plan/models/recipe.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MenuRepository {
  final AppointmentService appointmentService;

  MenuRepository({required this.appointmentService});

  Future<dynamic> fetchAppointments() async {
    final appointments = await appointmentService.fetchAppointments();
    return appointments;
  }

  Appointment addAndReturnAppointment({
    required Recipe recipe,
    required TimeOfDay start,
    required TimeOfDay end,
    required int day,
    required Color colorPicked,
  }) {
    return appointmentService.addAndReturnAppointment(
      recipe: recipe,
      start: start,
      end: end,
      day: day,
      colorPicked: colorPicked,
    );
  }

  void updateAndReturnAppointment({
    required ScheduleHive schedule,
    required Recipe recipe,
    required TimeOfDay start,
    required TimeOfDay end,
    required int day,
    required Color colorPicked,
  }) {
    appointmentService.updateAndReturnAppointment(
      schedule: schedule,
      recipe: recipe,
      start: start,
      end: end,
      day: day,
      colorPicked: colorPicked,
    );
  }
}
