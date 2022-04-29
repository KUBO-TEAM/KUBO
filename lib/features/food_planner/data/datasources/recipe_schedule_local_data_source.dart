import 'dart:collection';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/core/helpers/menu_linked_hashmap.dart';
import 'package:kubo/features/food_planner/data/models/recipe_schedule_model.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_recipe_schedule.dart';

const kRecipeScheduleBoxKey = 'Recipe Schedule Box Key';

abstract class RecipeScheduleLocalDataSource {
  /// create [RecipeScheduleModel] to the cached.
  ///
  /// Throws [CacheException] if data is not save.
  ///
  Future<String> createRecipeSchedule(
    CreateRecipeParams params,
  );

  /// Fetch the cached list  [RecipeScheduleModel]
  ///
  /// Throws [CacheException] if no cached data is present.
  ///
  Future<List<RecipeScheduleModel>> fetchRecipeSchedules();

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
  Future<Box<RecipeSchedule>> get recipeSchedule =>
      Hive.openBox(kRecipeScheduleBoxKey);
}

@LazySingleton(as: RecipeScheduleLocalDataSource)
class RecipeScheduleLocalDataSourceImpl
    implements RecipeScheduleLocalDataSource {
  final Box<RecipeScheduleModel> recipeScheduleBox;

  RecipeScheduleLocalDataSourceImpl({required this.recipeScheduleBox});

  @override
  Future<String> createRecipeSchedule(
    CreateRecipeParams params,
  ) async {
    await recipeScheduleBox.put(
      'test',
      RecipeScheduleModel(
        recipeId: params.recipeId,
        start: params.start,
        end: params.end,
        color: params.color,
        isAllDay: params.isAllDay,
      ),
    );

    return 'Successfully Created!';
  }

  @override
  Future<List<RecipeScheduleModel>> fetchRecipeSchedules() async {
    final List<RecipeScheduleModel> recipeSchedules = [];

    for (var recipeSchedule in recipeScheduleBox.values) {
      recipeSchedules.add(recipeSchedule);
    }

    return recipeSchedules;
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

    // for (var recipeSchedule in recipeScheduleBox.values) {
    //   final key = DateTime(
    //     recipeSchedule.start.year,
    //     recipeSchedule.start.month,
    //     recipeSchedule.start.day,
    //   );

    //   if (scheduleMap[key] == null) {
    //     scheduleMap[key] = [recipeSchedule];
    //   } else {
    //     final scheduleMapList = scheduleMap[key];

    //     if (scheduleMapList != null) {
    //       scheduleMapList.add(recipeSchedule);

    //       scheduleMap[key] = scheduleMapList;
    //     }
    //   }
    // }

    // scheduleLinkedHashMap.addAll(scheduleMap);

    return scheduleLinkedHashMap;
  }
}
