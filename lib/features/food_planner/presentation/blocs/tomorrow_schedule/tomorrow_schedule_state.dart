part of 'tomorrow_schedule_bloc.dart';

abstract class TomorrowScheduleState extends Equatable {
  const TomorrowScheduleState();

  @override
  List<Object> get props => [];
}

class TomorrowScheduleInitial extends TomorrowScheduleState {}

class TomorrowScheduleInProgress extends TomorrowScheduleState {}

class TomorrowScheduleSuccess extends TomorrowScheduleState {
  final RecipeSchedule? recipeSchedule;

  const TomorrowScheduleSuccess({required this.recipeSchedule});
}

class TomorrowScheduleFailure extends TomorrowScheduleState {
  final String message;

  const TomorrowScheduleFailure({required this.message});
}
