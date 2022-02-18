import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/core/helpers/menu_linked_hashmap.dart';
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

  /// Fetch the cached list  [RecipeScheduleModel]
  ///
  /// Throws [CacheException] if no cached data is present.
  ///
  Future<List<RecipeScheduleModel>> fetchRecipeScheduleList();

  /// Fetch the cached linked list of  [RecipeScheduleModel]
  ///
  /// Throws [CacheException] if no cached data is present
  ///
  Future<LinkedHashMap<DateTime, List<RecipeScheduleModel>>>
      fetchRecipeScheduleLinkedHashmap();
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
  Future<List<RecipeScheduleModel>> fetchRecipeScheduleList() async {
    final List<RecipeScheduleModel> schedules = [];

    for (var value in recipeScheduleBox.values) {
      var recipeSchedule = RecipeScheduleModel(
        id: value.id,
        name: value.name,
        description: value.description,
        imageUrl: value.imageUrl,
        start: value.start,
        end: value.end,
        color: value.color,
        isAllDay: false,
      );
      schedules.add(recipeSchedule);
    }

    return schedules;
  }

  @override
  Future<LinkedHashMap<DateTime, List<RecipeScheduleModel>>>
      fetchRecipeScheduleLinkedHashmap() async {
    if (recipeScheduleBox.isEmpty) {
      throw CacheException();
    }

    final scheduleLinkedHashMap =
        LinkedHashMap<DateTime, List<RecipeScheduleModel>>(
      equals: isSameDay,
      hashCode: getHashCode,
    );

    final Map<DateTime, List<RecipeScheduleModel>> scheduleMap = {};

    for (var value in recipeScheduleBox.values) {
      var recipeSchedule = RecipeScheduleModel(
        id: value.id,
        name: value.name,
        description: value.description,
        imageUrl: value.imageUrl,
        start: value.start,
        end: value.end,
        color: value.color,
        isAllDay: false,
      );

      final key =
          DateTime(value.start.year, value.start.month, value.start.day);

      if (scheduleMap[key] == null) {
        scheduleMap[key] = [recipeSchedule];
      } else {
        final scheduleMapList = scheduleMap[key];

        if (scheduleMapList != null) {
          scheduleMapList.add(recipeSchedule);

          scheduleMap[key] = scheduleMapList;
        }
      }
    }

    scheduleLinkedHashMap.addAll(scheduleMap);

    return scheduleLinkedHashMap;
  }
}
