import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'meal_plan_state.dart';

class MealPlanCubit extends Cubit<MealPlanState> {
  MealPlanCubit() : super(MealPlanInitial());
}
