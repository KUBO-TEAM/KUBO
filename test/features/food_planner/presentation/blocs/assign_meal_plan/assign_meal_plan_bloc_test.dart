import 'package:flutter_test/flutter_test.dart';
import 'package:kubo/features/food_planner/presentation/blocs/assign_meal/assign_meal_plan_bloc.dart';

import '../../../../../test_constants.dart';

void main() {
  late AssignMealPlanBloc assignMealPlanBloc;

  setUp(() {
    assignMealPlanBloc = AssignMealPlanBloc();
  });

  test('initial state should be AssignMealPlanInitial', () {
    expect(assignMealPlanBloc.state, AssignMealPlanInitial());
  });

  group('AssignMealPlanCellPressed', () {
    test(
      '''should emit [AssignMealPlanSuccess] when successfully get start date time''',
      () {
        final expected = [
          AssignMealPlanSuccess(
            startingDate: tStart,
          ),
        ];

        expectLater(assignMealPlanBloc.stream, emitsInOrder(expected));

        assignMealPlanBloc.add(
          AssignMealPlanCellPressed(startingDate: tStart),
        );
      },
    );
  });
}
