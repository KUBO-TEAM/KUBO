import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/get_all_recipe_schedule.dart';
import 'package:mockito/mockito.dart';

import 'create_recipe_schedule_test.mocks.dart';

void main() {
  late MockRecipeScheduleRepository mockRecipeScheduleRepository;
  late GetAllRecipeSchedule getAllRecipeSchedule;

  setUp(() {
    mockRecipeScheduleRepository = MockRecipeScheduleRepository();
    getAllRecipeSchedule = GetAllRecipeSchedule(mockRecipeScheduleRepository);
  });

  final List<RecipeSchedule> tRecipeScheduleList = [];

  test('should get all the RecipeSchedule from the repository', () async {
    when(mockRecipeScheduleRepository.getAllRecipeSchedule())
        .thenAnswer((_) async => Right(tRecipeScheduleList));

    final result = await getAllRecipeSchedule(NoParams());

    expect(result, equals(Right(tRecipeScheduleList)));
    verify(mockRecipeScheduleRepository.getAllRecipeSchedule());
  });
}
