part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}

class MenuRecipeScheduleFetchInProgress extends MenuState {
  final List<RecipeSchedule>? recipeSchedules;

  const MenuRecipeScheduleFetchInProgress({this.recipeSchedules});
}

class MenuRecipeScheduleFetchSuccess extends MenuState {
  final List<RecipeSchedule> recipeSchedules;

  const MenuRecipeScheduleFetchSuccess({required this.recipeSchedules});
}

class MenuRecipeScheduleFetchFailure extends MenuState {
  final String message;

  const MenuRecipeScheduleFetchFailure({
    required this.message,
  });
}

// Update Recipe Schedule List

class MenuRecipeScheduleUpdateFetchSuccess extends MenuState {
  final List<RecipeSchedule> recipeSchedules;

  const MenuRecipeScheduleUpdateFetchSuccess({required this.recipeSchedules});
}

class MenuRecipeScheduleUpdateFetchFailure extends MenuState {
  final String message;
  final List<RecipeSchedule> recipeSchedules;

  const MenuRecipeScheduleUpdateFetchFailure({
    required this.message,
    required this.recipeSchedules,
  });
}
