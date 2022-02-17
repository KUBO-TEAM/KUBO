part of 'recipe_schedule_bloc.dart';

abstract class RecipeScheduleEvent extends Equatable {
  const RecipeScheduleEvent();

  @override
  List<Object> get props => [];
}

class RecipeScheduleAdded extends RecipeScheduleEvent {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final TimeOfDay start;
  final TimeOfDay end;
  final int day;
  final Color color;
  final bool isAllDay;

  const RecipeScheduleAdded({
    required this.id,
    required this.name,
    required this.day,
    required this.description,
    required this.imageUrl,
    required this.start,
    required this.end,
    required this.color,
    required this.isAllDay,
  });
}

class RecipeSchedulesFetched extends RecipeScheduleEvent {}
