import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'assign_meal_plan_event.dart';
part 'assign_meal_plan_state.dart';

class AssignMealPlanBloc
    extends Bloc<AssignMealPlanEvent, AssignMealPlanState> {
  AssignMealPlanBloc()
      : super(
          AssignMealPlanInitial(),
        ) {
    on<AssignMealPlanEvent>((event, emit) {
      if (event is AssignMealPlanCellPressed) {
        emit(
          AssignMealPlanSuccess(startingDate: event.startingDate),
        );
      } else if (event is AssignMealPlanStartingDateRemoved) {
        emit(
          AssignMealPlanInitial(),
        );
      }
    });
  }
}
