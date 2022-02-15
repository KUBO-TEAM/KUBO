import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:kubo/core/hive/objects/recipe_schedule_hive.dart';
import 'package:kubo/features/food_planner/data/datasources/recipe_schedule_local_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_constants.dart';
import 'recipe_schedule_local_data_source_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<Box<RecipeScheduleHive>>(as: #MockRecipeScheduleBox)
])
void main() {
  late RecipeScheduleLocalDataSourceImpl dataSource;
  late MockRecipeScheduleBox mockRecipeScheduleBox;

  setUp(() {
    mockRecipeScheduleBox = MockRecipeScheduleBox();
    dataSource = RecipeScheduleLocalDataSourceImpl(
      recipeScheduleBox: mockRecipeScheduleBox,
    );
  });

  group('createRecipeSchedule', () {
    test(
        'should return RecipeScheduleModel when the data is created successfully',
        () async {
      final result = await dataSource.createRecipeSchedule(
        id: tId,
        name: tName,
        description: tDescription,
        imageUrl: tImageUrl,
        start: tStart,
        end: tEnd,
        color: tColor,
        isAllDay: tAllDay,
      );

      expect(result, equals(tRecipeScheduleModel));
    });
  });
}
