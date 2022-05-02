part of 'recipe_info_fetch_recipe_schedules_bloc.dart';

abstract class RecipeInfoFetchRecipeSchedulesState extends Equatable {
  const RecipeInfoFetchRecipeSchedulesState();

  @override
  List<Object> get props => [];
}

class RecipeInfoFetchRecipeSchedulesInitial
    extends RecipeInfoFetchRecipeSchedulesState {}

class RecipeInfoFetchRecipeSchedulesInProgress
    extends RecipeInfoFetchRecipeSchedulesState {}

class RecipeInfoFetchRecipeSchedulesSuccess
    extends RecipeInfoFetchRecipeSchedulesState {
  final List<RecipeSchedule> pastRecipeSchedules;
  final List<RecipeSchedule> futureRecipeSchedules;
  final RecipeSchedule? latestRecipeSchedule;

  const RecipeInfoFetchRecipeSchedulesSuccess({
    required this.pastRecipeSchedules,
    required this.futureRecipeSchedules,
    this.latestRecipeSchedule,
  });
}

class RecipeInfoFetchRecipeSchedulesFailure
    extends RecipeInfoFetchRecipeSchedulesState {
  final String message;

  const RecipeInfoFetchRecipeSchedulesFailure({required this.message});
}
