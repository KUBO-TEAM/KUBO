import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'meal_plan_state.dart';

class MealPlanCubit extends Cubit<MealPlanState> {
  MealPlanCubit() : super(MealPlanInitial());

  void setCellDate(DateTime startingDate) =>
      emit(CellDateSetSuccess(startingDate: startingDate));

  void removeCellDate() => emit(CellDateRemoveSuccess());
}
