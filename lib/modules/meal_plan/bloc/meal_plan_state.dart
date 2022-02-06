part of 'meal_plan_cubit.dart';

@immutable
abstract class MealPlanState {}

class MealPlanInitial extends MealPlanState {}

class CellDateSetSuccess extends MealPlanState {
  final DateTime? startingDate;

  CellDateSetSuccess({
    required this.startingDate,
  });
}

class CellDateRemoveSuccess extends MealPlanState {}
