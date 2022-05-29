part of 'tomorrow_schedule_bloc.dart';

abstract class TomorrowScheduleEvent extends Equatable {
  const TomorrowScheduleEvent();

  @override
  List<Object> get props => [];
}

class TomorrowScheduleFetched extends TomorrowScheduleEvent {}
