part of 'smart_recipe_list_bloc.dart';

abstract class SmartRecipeListState {
  const SmartRecipeListState();
}

class SmartRecipeListInitial extends SmartRecipeListState {}

class SmartRecipeListInProgress extends SmartRecipeListState {}

class SmartRecipeListSuccess extends SmartRecipeListState {
  final List<RecipeSchedule> recipeSchedules;

  const SmartRecipeListSuccess({required this.recipeSchedules});
}

class SmartRecipeListFailure extends SmartRecipeListState {
  final String message;

  const SmartRecipeListFailure({required this.message});
}
