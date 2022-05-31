part of 'agenda_bloc.dart';

abstract class AgendaState {
  const AgendaState();
}

class AgendaInitial extends AgendaState {}

class AgendaFetchInProgress extends AgendaState {
  final List<RecipeSchedule> recipeSchedules;
  const AgendaFetchInProgress({required this.recipeSchedules});
}

class AgendaFetchSuccess extends AgendaState {
  final List<RecipeSchedule> recipeSchedules;

  const AgendaFetchSuccess({required this.recipeSchedules});
}

class AgendaFetchFailure extends AgendaState {
  final String message;

  const AgendaFetchFailure({required this.message});
}

class AgendaUpdateFetchSuccess extends AgendaState {
  final List<RecipeSchedule> recipeSchedules;

  const AgendaUpdateFetchSuccess({required this.recipeSchedules});
}

class AgendaUpdateFetchFailure extends AgendaState {
  final String message;
  final List<RecipeSchedule> recipeSchedules;

  const AgendaUpdateFetchFailure({
    required this.message,
    required this.recipeSchedules,
  });
}
