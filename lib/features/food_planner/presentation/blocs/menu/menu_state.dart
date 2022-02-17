part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}

class MenuInProgress extends MenuState {}

class MenuSuccess extends MenuState {
  final List<RecipeSchedule> recipeSchedules;

  const MenuSuccess({required this.recipeSchedules});
}

class MenuFailure extends MenuState {
  final String message;

  const MenuFailure(this.message);
}
