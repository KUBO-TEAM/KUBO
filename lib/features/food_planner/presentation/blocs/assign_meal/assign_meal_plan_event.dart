part of 'assign_meal_plan_bloc.dart';

abstract class AssignMealPlanEvent extends Equatable {
  const AssignMealPlanEvent();

  @override
  List<Object> get props => [];
}

class AssignMealPlanCellPressed extends AssignMealPlanEvent {
  final DateTime startingDate;

  const AssignMealPlanCellPressed({
    required this.startingDate,
  });
}

class AssignMealPlanStartingDateRemoved extends AssignMealPlanEvent {}
