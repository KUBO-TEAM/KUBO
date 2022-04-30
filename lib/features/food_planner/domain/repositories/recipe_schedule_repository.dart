import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_recipe_schedule.dart';

abstract class RecipeScheduleRepository {
  Future<Either<Failure, String>> createRecipeSchedule(
    CreateRecipeParams params,
  );

  Future<Either<Failure, List<RecipeSchedule>>> fetchRecipeSchedules();

  Future<Either<Failure, LinkedHashMap<DateTime, List<RecipeSchedule>>>>
      fetchRecipeScheduleLinkedHashmap();
}
