import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:kubo/constants/string.constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuState(appointments: []));

  void addAppointment(Appointment appointment) {
    final _appointments = state.appointments;
    _appointments.add(appointment);
    emit(MenuState(appointments: _appointments));
  }

  Future<void> fetchSchedule() async {
    var scheduleBox = await Hive.openBox(kScheduleBox);
    final _appointments = state.appointments;

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
    }

    emit(MenuState(appointments: _appointments));
  }
}
