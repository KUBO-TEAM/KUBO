import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/core/hive/objects/recipe_schedule_hive.dart';
import 'package:kubo/features/food_planner/data/models/recipe_schedule_model.dart';

const kRecipeScheduleBoxKey = 'Recipe Schedule Box Key';

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

@module
abstract class RecipeScheduleBox {
  @preResolve
  Future<Box<RecipeScheduleHive>> get recipeSchedule =>
      Hive.openBox(kRecipeScheduleBoxKey);
}

@LazySingleton(as: RecipeScheduleLocalDataSource)
class RecipeScheduleLocalDataSourceImpl
    implements RecipeScheduleLocalDataSource {
  final Box<RecipeScheduleHive> recipeScheduleBox;

  RecipeScheduleLocalDataSourceImpl({required this.recipeScheduleBox});

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
  }) async {
    RecipeScheduleHive recipeScheduleHive = RecipeScheduleHive(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      start: start,
      end: end,
      color: color,
    );

    await recipeScheduleBox.put(id, recipeScheduleHive);

    return RecipeScheduleModel(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      start: start,
      end: end,
      color: color,
      isAllDay: isAllDay,
    );
  }

  @override
  Future<RecipeScheduleModel> getAllRecipeSchedule() async {
    throw UnimplementedError();
  }
}
