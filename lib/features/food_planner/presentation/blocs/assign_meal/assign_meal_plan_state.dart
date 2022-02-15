part of 'assign_meal_plan_bloc.dart';

abstract class AssignMealPlanState extends Equatable {
  @override
  List<Object> get props => [];
}

class AssignMealPlanInitial extends AssignMealPlanState {}

class AssignMealPlanSuccess extends AssignMealPlanState {
  final DateTime startingDate;

  AssignMealPlanSuccess({required this.startingDate});
}
