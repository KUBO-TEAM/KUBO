import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kubo/core/error/error_messages.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_recipe_schedule_linked_hash_map.dart';
import 'package:kubo/features/food_planner/presentation/blocs/menu_history/menu_history_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../test_constants.dart';
import 'menu_history_test.mocks.dart';

@GenerateMocks([FetchRecipeScheduleLinkedHashMap])
void main() {
  late MockFetchRecipeScheduleLinkedHashMap
      mockFetchRecipeScheduleLinkedHashMap;

  late MenuHistoryBloc bloc;

  setUp(() {
    mockFetchRecipeScheduleLinkedHashMap =
        MockFetchRecipeScheduleLinkedHashMap();
    bloc = MenuHistoryBloc(
        fetchRecipeScheduleLinkedHashMap: mockFetchRecipeScheduleLinkedHashMap);
  });

  group('fetchRecipeScheduleLinkedHashmap', () {
    test('should get linked hashmap from the fetch recipe schedule use case ',
        () async {
      when(mockFetchRecipeScheduleLinkedHashMap(any)).thenAnswer(
        (_) async => Right(tRecipeScheduleLinkedHashmap),
      );

      bloc.add(MenuHistoryRecipeScheduleFetched());

      await untilCalled(mockFetchRecipeScheduleLinkedHashMap(any));

      verify(
        mockFetchRecipeScheduleLinkedHashMap(NoParams()),
      );
    });

    test('''should emit [MenuHistoryInProgress, MenuHistorySuccess] 
        when linked hashmap of recipe schedules is gotten successful''',
        () async {
      when(mockFetchRecipeScheduleLinkedHashMap(any)).thenAnswer(
        (_) async => Right(
          tRecipeScheduleLinkedHashmap,
        ),
      );

      final expected = [
        MenuHistoryInProgress(),
        MenuHistorySuccess(
          recipeScheduleLinkedHashmap: tRecipeScheduleLinkedHashmap,
        ),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(MenuHistoryRecipeScheduleFetched());
    });

    test(
        'should emit [MenuHistoryInProgress, MenuHistoryFailure] when list of data is gotten fails',
        () async {
      when(mockFetchRecipeScheduleLinkedHashMap(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      final expected = [
        MenuHistoryInProgress(),
        MenuHistoryFailure(message: CACHE_FAILURE_MESSAGE),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(MenuHistoryRecipeScheduleFetched());
    });
  });
}
