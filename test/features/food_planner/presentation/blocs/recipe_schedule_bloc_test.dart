import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kubo/core/error/error_messages.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_recipe_schedule.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_schedule_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_constants.dart';
import 'recipe_schedule_bloc_test.mocks.dart';

@GenerateMocks([CreateRecipeSchedule])
void main() {
  late MockCreateRecipeSchedule mockCreateRecipeSchedule;
  late RecipeScheduleBloc bloc;

  setUp(() {
    mockCreateRecipeSchedule = MockCreateRecipeSchedule();
    bloc = RecipeScheduleBloc(createRecipeSchedule: mockCreateRecipeSchedule);
  });

  test('initial state of the bloc should be empty', () async {
    expect(bloc.state, equals(Empty()));
  });

  group('createRecipeSchedule', () {
    test('should get data from the create recipe usecase', () async {
      when(mockCreateRecipeSchedule(any))
          .thenAnswer((_) async => Right(tRecipeSchedule));

      bloc.add(CreateRecipeScheduleForMenu(
        id: tId,
        name: tName,
        description: tDescription,
        imageUrl: tImageUrl,
        start: tStart,
        end: tEnd,
        color: tColor,
        isAllDay: tAllDay,
      ));
      await untilCalled(mockCreateRecipeSchedule(any));

      verify(mockCreateRecipeSchedule(Params(
        id: tId,
        name: tName,
        description: tDescription,
        imageUrl: tImageUrl,
        start: tStart,
        end: tEnd,
        color: tColor,
        isAllDay: tAllDay,
      )));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully',
        () async {
      when(mockCreateRecipeSchedule(any))
          .thenAnswer((realInvocation) async => Right(tRecipeSchedule));

      final expected = [
        Loading(),
        Loaded(
          recipeSchedule: tRecipeSchedule,
        ),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(CreateRecipeScheduleForMenu(
        id: tId,
        name: tName,
        description: tDescription,
        imageUrl: tImageUrl,
        start: tStart,
        end: tEnd,
        color: tColor,
        isAllDay: tAllDay,
      ));
    });

    test('should emit [Loading, Error] when data is getting fails', () async {
      when(mockCreateRecipeSchedule(any))
          .thenAnswer((realInvocation) async => Left(CacheFailure()));

      final expected = [
        Loading(),
        const Error(CACHE_FAILURE_MESSAGE),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(
        CreateRecipeScheduleForMenu(
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
    });
  });
}
