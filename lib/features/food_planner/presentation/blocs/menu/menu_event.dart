part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class MenuTimeTableCellPressed extends MenuEvent {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final TimeOfDay start;
  final TimeOfDay end;
  final int day;
  final Color color;
  final bool isAllDay;

  const MenuTimeTableCellPressed({
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

class MenuRecipeScheduleListFetched extends MenuEvent {}
