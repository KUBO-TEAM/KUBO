part of 'menu_history_cubit.dart';

@immutable
abstract class MenuHistoryState {}

class MenuHistoryInitial extends MenuHistoryState {
  MenuHistoryInitial();
}

class MenuHistorySchedulesFetchSuccess extends MenuHistoryState {
  final LinkedHashMap<DateTime, List<Schedule>> newSchedules;

  MenuHistorySchedulesFetchSuccess({required this.newSchedules});
}
