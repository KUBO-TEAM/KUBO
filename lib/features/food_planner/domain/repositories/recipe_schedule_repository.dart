import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';

abstract class RecipeScheduleRepository {
  Future<Either<Failure, RecipeSchedule>> createRecipeSchedule({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required DateTime start,
    required DateTime end,
    required Color color,
    required bool isAllDay,
  });

  Future<Either<Failure, List<RecipeSchedule>>> fetchRecipeScheduleList();

  Future<Either<Failure, LinkedHashMap<DateTime, List<RecipeSchedule>>>>
      fetchRecipeScheduleLinkedHashmap();
}
