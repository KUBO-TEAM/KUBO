part of 'recipe_info_bloc.dart';

abstract class RecipeInfoState extends Equatable {
  const RecipeInfoState();

  @override
  List<Object> get props => [];
}

class RecipeInfoInitial extends RecipeInfoState {}

class RecipeInfoCreateRecipeScheduleInProgress extends RecipeInfoState {}

class RecipeInfoCreateRecipeScheduleSuccess extends RecipeInfoState {
  final String message;

  const RecipeInfoCreateRecipeScheduleSuccess({required this.message});
}

class RecipeInfoCreateRecipeScheduleFailure extends RecipeInfoState {
  final String message;

  const RecipeInfoCreateRecipeScheduleFailure({
    required this.message,
  });
}
