import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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

  void addAppointment(Appointment appointment) {
    final currentState = state;

    if (currentState is MenuLoaded) {
      List<Appointment> appointments = currentState.appointments;

      appointments.add(appointment);
      emit(MenuLoaded(appointments: appointments));
    }
  }
}
