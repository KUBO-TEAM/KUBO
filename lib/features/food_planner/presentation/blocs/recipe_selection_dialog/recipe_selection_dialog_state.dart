part of 'recipe_selection_dialog_bloc.dart';

abstract class RecipeSelectionDialogState {
  const RecipeSelectionDialogState();
}

class RecipeSelectionDialogInitial extends RecipeSelectionDialogState {}

class RecipeSelectionDialogInProgress extends RecipeSelectionDialogState {}

class RecipeSelectionDialogSuccess extends RecipeSelectionDialogState {
  final List<Category> categories;

  const RecipeSelectionDialogSuccess({required this.categories});
}

class RecipeSelectionDialogFailure extends RecipeSelectionDialogState {
  final String message;

  const RecipeSelectionDialogFailure({required this.message});
}
