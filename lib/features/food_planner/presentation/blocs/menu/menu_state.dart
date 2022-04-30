part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}

class MenuRecipeScheduleFetchInProgress extends MenuState {}

class MenuRecipeScheduleFetchSuccess extends MenuState {
  final List<RecipeSchedule> recipeSchedules;

  const MenuRecipeScheduleFetchSuccess({required this.recipeSchedules});
}

class MenuRecipeScheduleFetchFailure extends MenuState {
  final String message;

  const MenuRecipeScheduleFetchFailure({required this.message});
}
