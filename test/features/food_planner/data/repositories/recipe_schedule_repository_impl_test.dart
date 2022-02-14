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
        'should return a remote data when the call to remote data source is successfull ',
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
        'should return CacheFailure when the call to remote data source is unsuccessfull',
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
}
