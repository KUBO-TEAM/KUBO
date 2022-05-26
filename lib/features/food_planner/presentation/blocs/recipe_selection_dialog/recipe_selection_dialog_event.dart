part of 'recipe_selection_dialog_bloc.dart';

abstract class RecipeSelectionDialogEvent extends Equatable {
  const RecipeSelectionDialogEvent();

  @override
  List<Object> get props => [];
}

class RecipeSelectionDialogCategoriesFetched
    extends RecipeSelectionDialogEvent {}
