import 'package:dartz/dartz.dart';
import 'package:kubo/features/food_planner/domain/repositories/recipe_schedule_repository.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_recipe_schedule.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_constants.dart';
import 'create_recipe_schedule_test.mocks.dart';

@GenerateMocks([RecipeScheduleRepository])
void main() {
  late MockRecipeScheduleRepository mockRecipeScheduleRepository;
  late CreateRecipeSchedule createRecipeSchedule;

  setUp(() {
    mockRecipeScheduleRepository = MockRecipeScheduleRepository();
    createRecipeSchedule = CreateRecipeSchedule(mockRecipeScheduleRepository);
  });

  test(
      'should create RecipeSchedule, then return the created schedule from the repository.',
      () async {
    when(mockRecipeScheduleRepository.createRecipeSchedule(
      id: anyNamed('id'),
      name: anyNamed('name'),
      description: anyNamed('description'),
      imageUrl: anyNamed('imageUrl'),
      start: anyNamed('start'),
      end: anyNamed('end'),
      color: anyNamed('color'),
      isAllDay: anyNamed('isAllDay'),
    )).thenAnswer((_) async => Right(tRecipeSchedule));

    final result = await createRecipeSchedule(
      Params(
        id: tId,
        name: tName,
        description: tDescription,
        imageUrl: tImageUrl,
        start: tStart,
        end: tEnd,
        color: tColor,
        isAllDay: tAllDay,
      ),
    );

    verify(
      mockRecipeScheduleRepository.createRecipeSchedule(
        id: tId,
        name: tName,
        description: tDescription,
        imageUrl: tImageUrl,
        start: tStart,
        end: tEnd,
        color: tColor,
        isAllDay: tAllDay,
      ),
    );

    expect(result, Right(tRecipeSchedule));
  });
}
