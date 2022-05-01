part of 'recipe_info_fetch_recipe_schedules_bloc.dart';

abstract class RecipeInfoFetchRecipeSchedulesEvent extends Equatable {
  const RecipeInfoFetchRecipeSchedulesEvent();

  @override
  List<Object> get props => [];
}

class RecipeInfoFetchRecipeSchedulesFetched
    extends RecipeInfoFetchRecipeSchedulesEvent {
  final String recipeId;

  const RecipeInfoFetchRecipeSchedulesFetched({required this.recipeId});
}
