part of 'recipe_schedule_edit_bloc.dart';

abstract class RecipeScheduleEditState {
  const RecipeScheduleEditState();
}

class RecipeScheduleEditInitial extends RecipeScheduleEditState {}

class RecipeScheduleEditInProgress extends RecipeScheduleEditState {}

class RecipeScheduleEditSuccess extends RecipeScheduleEditState {
  final String message;

  const RecipeScheduleEditSuccess({required this.message});
}

class RecipeScheduleEditFailure extends RecipeScheduleEditState {
  final String message;

  const RecipeScheduleEditFailure({required this.message});
}
