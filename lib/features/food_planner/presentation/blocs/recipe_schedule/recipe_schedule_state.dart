part of 'recipe_schedule_bloc.dart';

abstract class RecipeScheduleState extends Equatable {
  const RecipeScheduleState();

  @override
  List<Object> get props => [];
}

class RecipeScheduleInitial extends RecipeScheduleState {}

class RecipeScheduleInProgress extends RecipeScheduleState {}

class RecipeScheduleSuccess extends RecipeScheduleState {
  final List<RecipeSchedule> recipeSchedules;

  const RecipeScheduleSuccess({required this.recipeSchedules});
}

class RecipeScheduleFailure extends RecipeScheduleState {
  final String message;

  const RecipeScheduleFailure(this.message);
}
