import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:kubo/core/hive/objects/recipe_schedule_hive.dart';
import 'package:kubo/features/food_planner/data/datasources/recipe_schedule_local_data_source.dart';
import 'package:kubo/features/food_planner/data/models/recipe_schedule_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_constants.dart';
import 'recipe_schedule_local_data_source_test.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [MockSpec<Box<RecipeScheduleHive>>(as: #MockRecipeScheduleBox)],
)
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
        displayPhoto: tDisplayPhoto,
        start: tStart,
        end: tEnd,
        color: tColor,
        isAllDay: tAllDay,
      );

      expect(result, equals(tRecipeScheduleModel));
    });
  });

  group('fetchRecipeScheduleList', () {
    test(
      'should return list of RecipeScheduleModel when data is fetched successfully',
      () async {
        when(mockRecipeScheduleBox.values).thenReturn([
          RecipeScheduleHive(
            id: tId,
            name: tName,
            description: tDescription,
            displayPhoto: tDisplayPhoto,
            start: tStart,
            end: tEnd,
            color: tColor,
          ),
        ]);

        when(mockRecipeScheduleBox.isEmpty).thenReturn(false);

        final result = await dataSource.fetchRecipeScheduleList();

        verify(mockRecipeScheduleBox.values);
        expect(result, equals([tRecipeScheduleModel]));
      },
    );
  });

  group('fetchRecipeScheduleLinkedHashmap', () {
    test('should return Recipe Schedule linked hashmap when data is fetched',
        () async {
      when(mockRecipeScheduleBox.values).thenReturn(
        [
          RecipeScheduleHive(
            id: tId,
            name: tName,
            description: tDescription,
            displayPhoto: tDisplayPhoto,
            start: tStart,
            end: tEnd,
            color: tColor,
          ),
        ],
      );

      when(mockRecipeScheduleBox.isEmpty).thenReturn(false);

      final result = await dataSource.fetchRecipeScheduleLinkedHashmap();

      verify(mockRecipeScheduleBox.values);
      expect(result, isA<LinkedHashMap<DateTime, List<RecipeScheduleModel>>>());
    });
  });
}
