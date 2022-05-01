part of 'recipe_info_create_recipe_schedule_bloc.dart';

abstract class RecipeInfoCreateRecipeScheduleState extends Equatable {
  const RecipeInfoCreateRecipeScheduleState();

  @override
  List<Object> get props => [];
}

class RecipeInfoCreateRecipeScheduleInitial
    extends RecipeInfoCreateRecipeScheduleState {}

class RecipeInfoCreateRecipeScheduleInProgress
    extends RecipeInfoCreateRecipeScheduleState {}

class RecipeInfoCreateRecipeScheduleSuccess
    extends RecipeInfoCreateRecipeScheduleState {
  final String message;

  const RecipeInfoCreateRecipeScheduleSuccess({required this.message});
}

class RecipeInfoCreateRecipeScheduleFailure
    extends RecipeInfoCreateRecipeScheduleState {
  final String message;

  const RecipeInfoCreateRecipeScheduleFailure({
    required this.message,
  });
}
