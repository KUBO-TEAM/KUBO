part of 'recipe_info_bloc.dart';

abstract class RecipeInfoEvent extends Equatable {
  const RecipeInfoEvent();

  @override
  List<Object> get props => [];
}

class RecipeInfoRecipeScheduleCreated extends RecipeInfoEvent {
  final Recipe? recipe;
  final int? day;
  final TimeOfDay? start;
  final TimeOfDay? end;
  final Color? color;

  const RecipeInfoRecipeScheduleCreated({
    required this.recipe,
    required this.day,
    required this.start,
    required this.end,
    required this.color,
  });
}
