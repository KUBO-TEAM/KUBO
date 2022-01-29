import 'package:kubo/core/services/appointment_service.dart';

class MenuRepository {
  final AppointmentService appointmentService;

  MenuRepository({required this.appointmentService});

  Future<dynamic> fetchAppointments() async {
    final appointments = await appointmentService.fetchAppointments();
    return appointments;
  }
}
