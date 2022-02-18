part of 'menu_history_bloc.dart';

abstract class MenuHistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MenuHistoryInitial extends MenuHistoryState {}

class MenuHistoryInProgress extends MenuHistoryState {}

class MenuHistorySuccess extends MenuHistoryState {
  final LinkedHashMap<DateTime, List<RecipeSchedule>>
      recipeScheduleLinkedHashmap;

  MenuHistorySuccess({required this.recipeScheduleLinkedHashmap});
}

class MenuHistoryFailure extends MenuHistoryState {
  final String message;

  MenuHistoryFailure({required this.message});
}
