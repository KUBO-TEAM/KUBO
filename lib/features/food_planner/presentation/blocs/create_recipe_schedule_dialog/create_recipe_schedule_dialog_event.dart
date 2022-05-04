part of 'create_recipe_schedule_dialog_bloc.dart';

abstract class CreateRecipeScheduleDialogEvent extends Equatable {
  const CreateRecipeScheduleDialogEvent();

  @override
  List<Object> get props => [];
}

class CreateRecipeScheduleDialogDateTimeSaved
    extends CreateRecipeScheduleDialogEvent {
  final DateTime startedTime;

  const CreateRecipeScheduleDialogDateTimeSaved({required this.startedTime});
}

class CreateRecipeScheduleDialogInitializeState
    extends CreateRecipeScheduleDialogEvent {}
