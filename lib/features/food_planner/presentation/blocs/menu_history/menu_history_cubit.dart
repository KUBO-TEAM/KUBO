import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:kubo/core/constants/menu_constants.dart';
import 'package:kubo/core/temp/menu_history_repositories.dart';
import 'package:kubo/core/temp/schedule.model.dart';
import 'package:meta/meta.dart';
import 'package:table_calendar/table_calendar.dart';

part 'menu_history_state.dart';

class MenuHistoryCubit extends Cubit<MenuHistoryState> {
  final MenuHistoryRepositories menuHistoryRepositories;

  MenuHistoryCubit({required this.menuHistoryRepositories})
      : super(MenuHistoryInitial());

  void fetchSchedule() {
    menuHistoryRepositories.fetchSchedules().then((scheduleBox) {
      if (scheduleBox.isEmpty == false) {
        final schedules = LinkedHashMap<DateTime, List<Schedule>>(
          equals: isSameDay,
          hashCode: getHashCode,
        );

        for (var element in scheduleBox.values) {}
      }
    });
  }
}
