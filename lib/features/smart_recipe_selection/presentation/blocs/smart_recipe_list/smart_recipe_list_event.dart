part of 'smart_recipe_list_bloc.dart';

abstract class SmartRecipeListEvent extends Equatable {
  const SmartRecipeListEvent();

  @override
  List<Object> get props => [];
}

class SmartRecipeListRecipeSchedulesGenerated extends SmartRecipeListEvent {
  final List<Category> categories;

  const SmartRecipeListRecipeSchedulesGenerated({required this.categories});
}

class SmartRecipeListRecipeSchedulesSaved extends SmartRecipeListEvent {
  final List<RecipeSchedule> recipeSchedules;
  final User user;

  const SmartRecipeListRecipeSchedulesSaved({
    required this.recipeSchedules,
    required this.user,
  });
}

class SmartRecipeListRecipeScheduleRecipeEdited extends SmartRecipeListEvent {
  final int recipeScheduleArrayIndex;
  final Recipe recipe;

  const SmartRecipeListRecipeScheduleRecipeEdited({
    required this.recipeScheduleArrayIndex,
    required this.recipe,
  });
}

class SmartRecipeListRecipeScheduleDeleted extends SmartRecipeListEvent {
  final int recipeScheduleArrayIndex;

  const SmartRecipeListRecipeScheduleDeleted({
    required this.recipeScheduleArrayIndex,
  });
}
