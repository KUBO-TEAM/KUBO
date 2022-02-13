import 'package:kubo/core/temp/local_storage_service.dart';

class MenuHistoryRepositories {
  final LocalStorageService localStorageService;

  MenuHistoryRepositories({required this.localStorageService});

  Future<dynamic> fetchSchedules() async {
    final schedules = await localStorageService.fetchSchedules();
    return schedules;
  }
}
