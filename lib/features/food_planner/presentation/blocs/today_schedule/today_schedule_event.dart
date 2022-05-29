part of 'today_schedule_bloc.dart';

abstract class TodayScheduleEvent extends Equatable {
  const TodayScheduleEvent();

  @override
  List<Object> get props => [];
}

class TodayScheduleFetched extends TodayScheduleEvent {}
