import 'package:hive/hive.dart';
import 'package:kubo/constants/string.constants.dart';

class AppointmentService {

  Future<dynamic> fetchAppointments() async {
    var scheduleBox = await Hive.openBox(kScheduleBox);

    if (scheduleBox.isEmpty == false) {
      return scheduleBox;
    }

    return null;
  }
}
