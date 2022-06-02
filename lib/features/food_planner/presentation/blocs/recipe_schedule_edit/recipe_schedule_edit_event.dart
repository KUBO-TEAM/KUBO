part of 'recipe_schedule_edit_bloc.dart';

abstract class RecipeScheduleEditEvent extends Equatable {
  const RecipeScheduleEditEvent();

  @override
  List<Object> get props => [];
}

class RecipeScheduleManualEdited extends RecipeScheduleEditEvent {
  final RecipeSchedule recipeSchedule;
  final String? day;
  final TimeOfDay? start;
  final TimeOfDay? end;
  final Color? color;

  const RecipeScheduleManualEdited({
    required this.recipeSchedule,
    required this.day,
    required this.start,
    required this.end,
    required this.color,
  });
}
