import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/features/food_planner/data/datasources/recipe_schedule_local_data_source.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'dart:ui';

import 'package:kubo/features/food_planner/domain/repositories/recipe_schedule_repository.dart';

@LazySingleton(as: RecipeScheduleRepository)
class RecipeScheduleRepositoryImpl implements RecipeScheduleRepository {
  final RecipeScheduleLocalDataSource localDataSource;

  RecipeScheduleRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, RecipeSchedule>> createRecipeSchedule({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required DateTime start,
    required DateTime end,
    required Color color,
    required bool isAllDay,
  }) async {
    try {
      final newRecipeSchedule = await localDataSource.createRecipeSchedule(
        id: id,
        name: name,
        description: description,
        imageUrl: imageUrl,
        start: start,
        end: end,
        color: color,
        isAllDay: isAllDay,
      );

      return Right(newRecipeSchedule);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeSchedule>>> getAllRecipeSchedule() {
    // TODO: implement getAllRecipeSchedule
    throw UnimplementedError();
  }
}
