part of 'recipe_bloc.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object> get props => [];
}

class RecipeInitial extends RecipeState {}

class RecipeInProgress extends RecipeState {}

class RecipeSuccess extends RecipeState {
  final List<RecipeModel> recipes;
  final List<RecipeModel> cached;

  const RecipeSuccess({required this.recipes, required this.cached});
}

class RecipeFailure extends RecipeState {}