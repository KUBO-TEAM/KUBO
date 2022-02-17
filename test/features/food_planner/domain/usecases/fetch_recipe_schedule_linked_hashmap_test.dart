import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_recipe_schedule_linked_hash_map.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_constants.dart';
import 'create_recipe_schedule_test.mocks.dart';

void main() {
  late MockRecipeScheduleRepository mockRecipeScheduleRepository;
  late FetchRecipeScheduleLinkedHashMap fetchRecipeScheduleLinkedHashMap;

  setUp(() {
    mockRecipeScheduleRepository = MockRecipeScheduleRepository();
    fetchRecipeScheduleLinkedHashMap =
        FetchRecipeScheduleLinkedHashMap(mockRecipeScheduleRepository);
  });

  test(
    'should fetch LinkedHashMap of RecipeSchedule from the repository ',
    () async {
      when(mockRecipeScheduleRepository.fetchRecipeScheduleLinkedHashmap())
          .thenAnswer((_) async => Right(tRecipeScheduleLinkedHashmap));

      final result = await fetchRecipeScheduleLinkedHashMap(NoParams());

      verify(mockRecipeScheduleRepository.fetchRecipeScheduleLinkedHashmap());

      expect(result, equals(Right(tRecipeScheduleLinkedHashmap)));
    },
  );
}
