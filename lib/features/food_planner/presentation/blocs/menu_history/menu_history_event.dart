part of 'menu_history_bloc.dart';

abstract class MenuHistoryEvent extends Equatable {
  const MenuHistoryEvent();

  @override
  List<Object> get props => [];
}

class MenuHistoryRecipeScheduleFetched extends MenuHistoryEvent {}
