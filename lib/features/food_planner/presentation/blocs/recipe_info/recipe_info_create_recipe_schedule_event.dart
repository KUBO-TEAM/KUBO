part of 'recipe_info_create_recipe_schedule_bloc.dart';

abstract class RecipeInfoCreateRecipeScheduleEvent extends Equatable {
  const RecipeInfoCreateRecipeScheduleEvent();

  @override
  List<Object> get props => [];
}

class RecipeInfoCreateRecipeScheduleCreated
    extends RecipeInfoCreateRecipeScheduleEvent {
  final Recipe? recipe;
  final String? day;
  final TimeOfDay? start;
  final TimeOfDay? end;
  final Color? color;
  final User user;

  const RecipeInfoCreateRecipeScheduleCreated({
    required this.recipe,
    required this.day,
    required this.start,
    required this.end,
    required this.color,
    required this.user,
  });
}
