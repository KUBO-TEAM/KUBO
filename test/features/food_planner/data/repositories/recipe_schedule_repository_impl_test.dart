import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/features/food_planner/data/datasources/recipe_schedule_local_data_source.dart';
import 'package:kubo/features/food_planner/data/repositories/recipe_schedule_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_constants.dart';
import 'recipe_schedule_repository_impl_test.mocks.dart';

@GenerateMocks([RecipeScheduleLocalDataSource])
void main() {
  late MockRecipeScheduleLocalDataSource mockRecipeScheduleLocalDataSource;
  late RecipeScheduleRepositoryImpl repository;

  setUp(() {
    mockRecipeScheduleLocalDataSource = MockRecipeScheduleLocalDataSource();
    repository = RecipeScheduleRepositoryImpl(
      localDataSource: mockRecipeScheduleLocalDataSource,
    );
  });

  group(
    'createRecipeSchedule',
    () {
      test(
        'should return a local data when the call to local data source is successfull ',
        () async {
          when(
            mockRecipeScheduleLocalDataSource.createRecipeSchedule(
              id: anyNamed('id'),
              name: anyNamed('name'),
              description: anyNamed('description'),
              imageUrl: anyNamed('imageUrl'),
              start: anyNamed('start'),
              end: anyNamed('end'),
              color: anyNamed('color'),
              isAllDay: anyNamed('isAllDay'),
            ),
          ).thenAnswer(
            (_) async => tRecipeScheduleModel,
          );

          final result = await repository.createRecipeSchedule(
            id: tId,
            name: tName,
            description: tDescription,
            imageUrl: tImageUrl,
            start: tStart,
            end: tEnd,
            color: tColor,
            isAllDay: tAllDay,
          );

          verify(
            mockRecipeScheduleLocalDataSource.createRecipeSchedule(
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

          expect(result, equals(Right(tRecipeSchedule)));
        },
      );

      test(
        'should return CacheFailure when the call to local data source is unsuccessfull',
        () async {
          when(
            mockRecipeScheduleLocalDataSource.createRecipeSchedule(
              id: anyNamed('id'),
              name: anyNamed('name'),
              description: anyNamed('description'),
              imageUrl: anyNamed('imageUrl'),
              start: anyNamed('start'),
              end: anyNamed('end'),
              color: anyNamed('color'),
              isAllDay: anyNamed('isAllDay'),
            ),
          ).thenThrow(CacheException());

          final result = await repository.createRecipeSchedule(
            id: tId,
            name: tName,
            description: tDescription,
            imageUrl: tImageUrl,
            start: tStart,
            end: tEnd,
            color: tColor,
            isAllDay: tAllDay,
          );

          verify(
            mockRecipeScheduleLocalDataSource.createRecipeSchedule(
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

          expect(result, equals(Left(CacheFailure())));
        },
      );
    },
  );

  final tListSchedule = [tRecipeScheduleModel];

  group('fetchRecipeScheduleList', () {
    test(
        'should return list of data when the call local data source is called.',
        () async {
      when(mockRecipeScheduleLocalDataSource.fetchRecipeScheduleList())
          .thenAnswer((_) async => tListSchedule);

      final result = await repository.fetchRecipeScheduleList();

      verify(mockRecipeScheduleLocalDataSource.fetchRecipeScheduleList());

      expect(result, equals(Right(tListSchedule)));
    });

    test('should return CacheFailure fetch list RecipeSchedule fails',
        () async {
      when(mockRecipeScheduleLocalDataSource.fetchRecipeScheduleList())
          .thenThrow(CacheException());

      final result = await repository.fetchRecipeScheduleList();

      verify(mockRecipeScheduleLocalDataSource.fetchRecipeScheduleList());
      expect(result, equals(Left(CacheFailure())));
    });
  });

  group('fetchRecipeScheduleLinkedHashmap', () {
    test(
      'should return linked hasmap when local data source is called',
      () async {
        when(mockRecipeScheduleLocalDataSource
                .fetchRecipeScheduleLinkedHashmap())
            .thenAnswer((_) async => tRecipeScheduleModelLinkedHashmap);

        final result = await repository.fetchRecipeScheduleLinkedHashmap();

        verify(mockRecipeScheduleLocalDataSource
            .fetchRecipeScheduleLinkedHashmap());

        expect(result, equals(Right(tRecipeScheduleModelLinkedHashmap)));
      },
    );
  });
}
