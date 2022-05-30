part of 'recipe_updates_bloc.dart';

abstract class RecipeUpdatesState {
  const RecipeUpdatesState();
}

class RecipeUpdatesInitial extends RecipeUpdatesState {}

class RecipeUpdatesInProgress extends RecipeUpdatesState {}

class RecipeUpdatesSuccess extends RecipeUpdatesState {
  final Recipe recipe;

  const RecipeUpdatesSuccess({
    required this.recipe,
  });
}

class RecipeUpdatesFailure extends RecipeUpdatesState {
  final String message;

  const RecipeUpdatesFailure({
    required this.message,
  });
}
