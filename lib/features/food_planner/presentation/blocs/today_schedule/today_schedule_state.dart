part of 'today_schedule_bloc.dart';

abstract class TodayScheduleState extends Equatable {
  const TodayScheduleState();

  @override
  List<Object> get props => [];
}

class TodayScheduleInitial extends TodayScheduleState {}

class TodayScheduleInProgress extends TodayScheduleState {}

class TodayScheduleSuccess extends TodayScheduleState {
  final RecipeSchedule? recipeSchedule;

  const TodayScheduleSuccess({required this.recipeSchedule});
}

class TodayScheduleFailure extends TodayScheduleState {
  final String message;

  const TodayScheduleFailure({required this.message});
}
