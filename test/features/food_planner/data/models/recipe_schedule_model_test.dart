import 'package:flutter_test/flutter_test.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_constants.dart';

void main() {
  test('should be a subclass of RecipeSchedule', () {
    expect(tRecipeScheduleModel, isA<RecipeSchedule>());
  });
}
