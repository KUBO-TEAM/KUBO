part of 'smart_recipe_list_bloc.dart';

abstract class SmartRecipeListState {
  const SmartRecipeListState();
}

class SmartRecipeListInitial extends SmartRecipeListState {}

class SmartRecipeListFetchInProgress extends SmartRecipeListState {}

class SmartRecipeListFetchSuccess extends SmartRecipeListState {
  final List<RecipeSchedule> recipeSchedules;

  const SmartRecipeListFetchSuccess({required this.recipeSchedules});
}

class SmartRecipeListFetchFailure extends SmartRecipeListState {
  final String message;

  const SmartRecipeListFetchFailure({required this.message});
}

class SmartRecipeListCreateSuccess extends SmartRecipeListState {
  final String message;

  const SmartRecipeListCreateSuccess({required this.message});
}
