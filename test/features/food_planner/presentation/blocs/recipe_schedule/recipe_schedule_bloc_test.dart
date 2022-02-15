import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kubo/core/error/error_messages.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/core/helpers/date_converter.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_recipe_schedule.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_schedule/recipe_schedule_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../test_constants.dart';
import 'recipe_schedule_bloc_test.mocks.dart';

@GenerateMocks([CreateRecipeSchedule, DateConverter])
void main() {
  late MockCreateRecipeSchedule mockCreateRecipeSchedule;
  late MockDateConverter mockDateConverter;
  late RecipeScheduleBloc bloc;

  setUp(() {
    mockCreateRecipeSchedule = MockCreateRecipeSchedule();
    mockDateConverter = MockDateConverter();
    bloc = RecipeScheduleBloc(
      createRecipeSchedule: mockCreateRecipeSchedule,
      dateConverter: mockDateConverter,
    );
  });

  test('initial state of the bloc should be RecipeScheduleInitial', () async {
    expect(bloc.state, equals(RecipeScheduleInitial()));
  });

  group('createRecipeSchedule', () {
    test('should get data from the create recipe usecase', () async {
      when(mockCreateRecipeSchedule(any)).thenAnswer(
        (_) async => Right(tRecipeSchedule),
      );

      when(
        mockDateConverter.convertStartAndEndTimeOfDay(
          day: anyNamed('day'),
          startTimeOfDay: anyNamed('startTimeOfDay'),
          endTimeOfDay: anyNamed('endTimeOfDay'),
        ),
      ).thenReturn(
        Right(
          StartAndEndTimeOfDay(
            start: tStart,
            end: tEnd,
          ),
        ),
      );

      bloc.add(const CreateRecipeScheduleForMenu(
        id: tId,
        name: tName,
        description: tDescription,
        imageUrl: tImageUrl,
        day: tDay,
        start: tStartTimeOfDay,
        end: tEndTimeOfDay,
        color: tColor,
        isAllDay: tAllDay,
      ));

      await untilCalled(mockCreateRecipeSchedule(any));

      verify(
        mockDateConverter.convertStartAndEndTimeOfDay(
          day: tDay,
          startTimeOfDay: tStartTimeOfDay,
          endTimeOfDay: tEndTimeOfDay,
        ),
      );

      verify(
        mockCreateRecipeSchedule(
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
        ),
      );
    });

    test(
        'should emit [RecipeScheduleInProgress, RecipeScheduleSuccess] when data is gotten successfully',
        () async {
      when(mockCreateRecipeSchedule(any))
          .thenAnswer((_) async => Right(tRecipeSchedule));

      when(
        mockDateConverter.convertStartAndEndTimeOfDay(
          day: anyNamed('day'),
          startTimeOfDay: anyNamed('startTimeOfDay'),
          endTimeOfDay: anyNamed('endTimeOfDay'),
        ),
      ).thenReturn(
        Right(
          StartAndEndTimeOfDay(
            start: tStart,
            end: tEnd,
          ),
        ),
      );

      final expected = [
        RecipeScheduleInProgress(),
        RecipeScheduleSuccess(
          recipeSchedules: [tRecipeSchedule],
        ),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const CreateRecipeScheduleForMenu(
        id: tId,
        name: tName,
        description: tDescription,
        imageUrl: tImageUrl,
        day: tDay,
        start: tStartTimeOfDay,
        end: tEndTimeOfDay,
        color: tColor,
        isAllDay: tAllDay,
      ));
    });

    test(
        'should emit [RecipeScheduleInProgress, RecipeScheduleFailure] when data is getting fails',
        () async {
      when(mockCreateRecipeSchedule(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      when(
        mockDateConverter.convertStartAndEndTimeOfDay(
          day: anyNamed('day'),
          startTimeOfDay: anyNamed('startTimeOfDay'),
          endTimeOfDay: anyNamed('endTimeOfDay'),
        ),
      ).thenReturn(
        Right(
          StartAndEndTimeOfDay(
            start: tStart,
            end: tEnd,
          ),
        ),
      );

      final expected = [
        RecipeScheduleInProgress(),
        const RecipeScheduleFailure(CACHE_FAILURE_MESSAGE),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(
        const CreateRecipeScheduleForMenu(
          id: tId,
          name: tName,
          description: tDescription,
          imageUrl: tImageUrl,
          day: tDay,
          start: tStartTimeOfDay,
          end: tEndTimeOfDay,
          color: tColor,
          isAllDay: tAllDay,
        ),
      );
    });

    test(
        'should emit [RecipeScheduleInProgress, RecipeScheduleFailure] when date time conversion fail',
        () {
      when(mockDateConverter.convertStartAndEndTimeOfDay(
        day: anyNamed('day'),
        startTimeOfDay: anyNamed('startTimeOfDay'),
        endTimeOfDay: anyNamed('endTimeOfDay'),
      )).thenReturn(
        Left(
          DateConverterFailure(),
        ),
      );

      final expected = [
        RecipeScheduleInProgress(),
        const RecipeScheduleFailure(DATE_CONVERTER_FAILURE_MESSAGE),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(
        const CreateRecipeScheduleForMenu(
          id: tId,
          name: tName,
          description: tDescription,
          imageUrl: tImageUrl,
          day: tDay,
          start: tStartTimeOfDay,
          end: tEndTimeOfDay,
          color: tColor,
          isAllDay: tAllDay,
        ),
      );
    });
  });
}
