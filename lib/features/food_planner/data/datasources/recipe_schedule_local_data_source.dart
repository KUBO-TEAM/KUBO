import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/hive/objects/schedule.hive.dart';
import 'package:kubo/features/food_planner/data/models/recipe_schedule_model.dart';

abstract class RecipeScheduleLocalDataSource {
  /// create [RecipeScheduleModel] to the cached.
  ///
  /// Throws [CacheException] if data is not save.
  ///
  Future<RecipeScheduleModel> createRecipeSchedule({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required DateTime start,
    required DateTime end,
    required Color color,
    required bool isAllDay,
  });

  /// Gets the cached [RecipeScheduleModel]
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  ///
  Future<RecipeScheduleModel> getAllRecipeSchedule();
}

@lazySingleton
class RecipeScheduleLocalDataSourceImpl
    implements RecipeScheduleLocalDataSource {
  @override
  Future<RecipeScheduleModel> createRecipeSchedule({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required DateTime start,
    required DateTime end,
    required Color color,
    required bool isAllDay,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<RecipeScheduleModel> getAllRecipeSchedule() {
    // TODO: implement getAllRecipeSchedule
    throw UnimplementedError();
  }
}
