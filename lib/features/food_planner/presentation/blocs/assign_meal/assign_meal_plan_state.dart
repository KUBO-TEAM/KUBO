part of 'assign_meal_plan_bloc.dart';

abstract class AssignMealPlanState extends Equatable {}

class AssignMealPlanInitial extends AssignMealPlanState {
  @override
  List<Object> get props => [];
}

class AssignMealPlanSuccess extends AssignMealPlanState {
  final DateTime startingDate;

  AssignMealPlanSuccess({required this.startingDate});

  @override
  List<Object> get props => [startingDate];
}
