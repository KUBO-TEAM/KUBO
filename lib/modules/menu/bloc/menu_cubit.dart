import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kubo/core/models/schedule.hive.dart';
import 'package:kubo/modules/meal_plan/models/recipe.dart';
import 'package:kubo/modules/menu/bloc/menu_repository.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  final MenuRepository menuRepository;

  MenuCubit({required this.menuRepository}) : super(MenuInitial());

  void fetchAppointments() {
    menuRepository.fetchAppointments().then((scheduleBox) {
      final List<Appointment> _appointments = [];

      if (scheduleBox.isEmpty == false) {
        for (var element in scheduleBox.values) {
          _appointments.add(
            Appointment(
              startTime: element.startTime,
              endTime: element.endTime,
              subject: element.recipeName,
              color: element.color,
            ),
          );
        }

        emit(MenuLoaded(appointments: _appointments));
      }
    });
  }

  void addAppointment({
    required Recipe recipe,
    required TimeOfDay start,
    required TimeOfDay end,
    required int day,
    required Color colorPicked,
  }) {
    final currentState = state;

    if (currentState is MenuLoaded) {
      List<Appointment> appointments = currentState.appointments;

      Appointment newAppointment = menuRepository.addAndReturnAppointment(
        recipe: recipe,
        start: start,
        end: end,
        day: day,
        colorPicked: colorPicked,
      );

      appointments.add(newAppointment);

      emit(MenuLoaded(appointments: appointments));
    }
  }

  void updateAppointment({
    required ScheduleHive schedule,
    required Recipe recipe,
    required TimeOfDay start,
    required TimeOfDay end,
    required int day,
    required Color colorPicked,
  }) {
    menuRepository.updateAndReturnAppointment(
      schedule: schedule,
      recipe: recipe,
      start: start,
      end: end,
      day: day,
      colorPicked: colorPicked,
    );

    // Temporary
    fetchAppointments();
  }
}
