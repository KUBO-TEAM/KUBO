part of 'create_recipe_schedule_dialog_bloc.dart';

abstract class CreateRecipeScheduleDialogState extends Equatable {
  const CreateRecipeScheduleDialogState();

  @override
  List<Object> get props => [];
}

class CreateRecipeScheduleDialogInitial
    extends CreateRecipeScheduleDialogState {}

class CreateRecipeScheduleDialogInProgress
    extends CreateRecipeScheduleDialogState {}

class CreateRecipeScheduleDialogSuccess
    extends CreateRecipeScheduleDialogState {
  final TimeOfDay start;
  final TimeOfDay end;
  final String day;

  const CreateRecipeScheduleDialogSuccess({
    required this.start,
    required this.end,
    required this.day,
  });
}

class CreateRecipeScheduleDialogFailure
    extends CreateRecipeScheduleDialogState {
  final String message;

  const CreateRecipeScheduleDialogFailure({
    required this.message,
  });
}
