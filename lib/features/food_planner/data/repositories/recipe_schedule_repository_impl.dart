import 'dart:collection';

import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/features/food_planner/data/datasources/recipe_schedule_local_data_source.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import 'package:kubo/features/food_planner/domain/repositories/recipe_schedule_repository.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_recipe_schedule.dart';

@LazySingleton(as: RecipeScheduleRepository)
class RecipeScheduleRepositoryImpl implements RecipeScheduleRepository {
  final RecipeScheduleLocalDataSource recipeLocalDataSource;

  RecipeScheduleRepositoryImpl({required this.recipeLocalDataSource});

  @override
  Future<Either<Failure, CreateRecipeScheduleResponse>> createRecipeSchedule(
    recipeSchedule,
  ) async {
    try {
      final response = await recipeLocalDataSource.createRecipeSchedule(
        recipeSchedule,
      );

      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeSchedule>>> fetchRecipeSchedules() async {
    try {
      final recipeSchedules =
          await recipeLocalDataSource.fetchRecipeSchedules();

      return Right(recipeSchedules);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, LinkedHashMap<DateTime, List<RecipeSchedule>>>>
      fetchRecipeScheduleLinkedHashmap() async {
    try {
      final schedules =
          await recipeLocalDataSource.fetchRecipeScheduleLinkedHashmap();

      return Right(schedules);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
