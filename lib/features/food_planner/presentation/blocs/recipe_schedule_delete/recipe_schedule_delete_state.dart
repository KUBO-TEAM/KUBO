part of 'recipe_schedule_delete_bloc.dart';

abstract class RecipeScheduleDeleteState {
  const RecipeScheduleDeleteState();
}

class RecipeScheduleDeleteInitial extends RecipeScheduleDeleteState {}

class RecipeScheduleDeleteInProgress extends RecipeScheduleDeleteState {}

class RecipeScheduleDeleteSuccess extends RecipeScheduleDeleteState {
  final String message;

  const RecipeScheduleDeleteSuccess({required this.message});
}

class RecipeScheduleDeleteFailure extends RecipeScheduleDeleteState {
  final String message;

  const RecipeScheduleDeleteFailure({required this.message});
}
