import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:kubo/constants/string.constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MenuNotifier extends ChangeNotifier {
  final List<Appointment> _appointments = [];

  UnmodifiableListView<Appointment> get appointments {
    return UnmodifiableListView(_appointments);
  }

  Future<void> fetchSchedule() async {
    var scheduleBox = await Hive.openBox(kScheduleBox);

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

    notifyListeners();
  }

  void addAppointment(Appointment appointment) {
    _appointments.add(appointment);
    notifyListeners();
  }
}
