part of 'recipe_schedule_bloc.dart';

abstract class RecipeScheduleState extends Equatable {
  const RecipeScheduleState();

  @override
  List<Object> get props => [];
}

class Empty extends RecipeScheduleState {}

class Loading extends RecipeScheduleState {}

class Loaded extends RecipeScheduleState {
  final List<RecipeSchedule> recipeSchedules;

  const Loaded({required this.recipeSchedules});
}

class Error extends RecipeScheduleState {
  final String message;

  const Error(this.message);
}
