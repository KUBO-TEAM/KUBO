part of 'recipe_schedule_delete_bloc.dart';

abstract class RecipeScheduleDeleteEvent extends Equatable {
  const RecipeScheduleDeleteEvent();

  @override
  List<Object> get props => [];
}

class RecipeScheduleDeleted extends RecipeScheduleDeleteEvent {
  final RecipeSchedule recipeSchedule;

  const RecipeScheduleDeleted({required this.recipeSchedule});
}
