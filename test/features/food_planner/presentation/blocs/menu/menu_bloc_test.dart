import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kubo/core/error/error_messages.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/core/helpers/date_converter.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_recipe_schedule_list.dart';
import 'package:kubo/features/food_planner/presentation/blocs/menu/menu_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../test_constants.dart';
import 'menu_bloc_test.mocks.dart';

@GenerateMocks([CreateRecipeSchedule, FetchRecipeScheduleList, DateConverter])
void main() {
  late MockCreateRecipeSchedule mockCreateRecipeSchedule;
  late MockFetchRecipeScheduleList mockFetchRecipeScheduleList;
  late MockDateConverter mockDateConverter;
  late MenuBloc bloc;

  setUp(() {
    mockCreateRecipeSchedule = MockCreateRecipeSchedule();
    mockFetchRecipeScheduleList = MockFetchRecipeScheduleList();

    mockDateConverter = MockDateConverter();
    bloc = MenuBloc(
      createRecipeSchedule: mockCreateRecipeSchedule,
      fetchRecipeScheduleList: mockFetchRecipeScheduleList,
      dateConverter: mockDateConverter,
    );
  });

  test('initial state of the bloc should be RecipeScheduleInitial', () async {
    expect(bloc.state, equals(MenuInitial()));
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
          StartAndEndDateTime(
            start: tStart,
            end: tEnd,
          ),
        ),
      );

      bloc.add(const MenuTimeTableRecipeScheduleAdded(
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
        'should emit [MenuInProgress, MenuSuccess] when data is gotten successfully',
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
          StartAndEndDateTime(
            start: tStart,
            end: tEnd,
          ),
        ),
      );

      final expected = [
        MenuInProgress(),
        MenuSuccess(
          recipeSchedules: [tRecipeSchedule],
        ),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const MenuTimeTableRecipeScheduleAdded(
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

    test('should emit [MenuInProgress, MenuFailure] when data is getting fails',
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
          StartAndEndDateTime(
            start: tStart,
            end: tEnd,
          ),
        ),
      );

      final expected = [
        MenuInProgress(),
        const MenuFailure(CACHE_FAILURE_MESSAGE),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(
        const MenuTimeTableRecipeScheduleAdded(
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
        'should emit [MenuInProgress, MenuFailure] when date time conversion fail',
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
        MenuInProgress(),
        const MenuFailure(DATE_CONVERTER_FAILURE_MESSAGE),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(
        const MenuTimeTableRecipeScheduleAdded(
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

  group('fetchRecipeScheduleList', () {
    test(
      'should get list of data from the fetch recipe use case',
      () async {
        when(mockFetchRecipeScheduleList(any)).thenAnswer(
          (_) async => Right([
            tRecipeSchedule,
          ]),
        );

        bloc.add(MenuRecipeScheduleListFetched());

        await untilCalled(mockFetchRecipeScheduleList(any));

        verify(
          mockFetchRecipeScheduleList(NoParams()),
        );
      },
    );

    test(
        'should emit [MenuInProgress, MenuSuccess] when list of data is gotten successful',
        () async {
      when(mockFetchRecipeScheduleList(any)).thenAnswer(
        (_) async => Right([
          tRecipeSchedule,
        ]),
      );

      final expected = [
        MenuInProgress(),
        MenuSuccess(
          recipeSchedules: [tRecipeSchedule],
        ),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(MenuRecipeScheduleListFetched());
    });

    test(
        'should emit [MenuInProgress, MenuFailure] when list of data is gotten fails',
        () async {
      when(mockFetchRecipeScheduleList(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      final expected = [
        MenuInProgress(),
        const MenuFailure(CACHE_FAILURE_MESSAGE),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(MenuRecipeScheduleListFetched());
    });
  });

  group('updateRecipeScheduleList', () {
    test(
        'should pass the updated recipe schedule list and emit [MenuInProgress, MenuSuccess]',
        () {
      when(mockFetchRecipeScheduleList(any)).thenAnswer(
        (_) async => Right([
          tRecipeSchedule,
        ]),
      );

      final expected = [
        MenuInProgress(),
        MenuSuccess(recipeSchedules: [tRecipeSchedule]),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(
        MenuRecipeScheduleListFetched(),
      );

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(
        MenuRecipeScheduleListUpdated(
          updatedRecipeScheduleHive: tRecipeScheduleHive,
        ),
      );

      verifyNoMoreInteractions(mockCreateRecipeSchedule);
      verifyNoMoreInteractions(mockFetchRecipeScheduleList);
      verifyNoMoreInteractions(mockDateConverter);
    });
  });
}
