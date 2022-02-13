part of 'menu_cubit.dart';

@immutable
abstract class MenuState {}

class MenuInitial extends MenuState {}

class MenuLoaded extends MenuState {
  final List<Schedule> schedules;

  MenuLoaded({required this.schedules});
}
