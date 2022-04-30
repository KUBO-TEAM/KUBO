import 'dart:collection';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/core/helpers/menu_linked_hashmap.dart';
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

  /// Fetch the cached list  [RecipeSchedule]
  ///
  /// Throws [CacheException] if no cached data is present.
  ///
  Future<List<RecipeSchedule>> fetchRecipeSchedules();

  /// Fetch the cached linked list of  [RecipeSchedule]
  ///
  /// Throws [CacheException] if no cached data is present
  ///
  Future<LinkedHashMap<DateTime, List<RecipeSchedule>>>
      fetchRecipeScheduleLinkedHashmap();
}

@LazySingleton(as: RecipeScheduleLocalDataSource)
class RecipeScheduleLocalDataSourceImpl
    implements RecipeScheduleLocalDataSource {
  final Box<RecipeSchedule> recipeScheduleBox;

  RecipeScheduleLocalDataSourceImpl({required this.recipeScheduleBox});

  @override
  Future<String> createRecipeSchedule(
    CreateRecipeParams params,
  ) async {
    final recipeScheduleModel = RecipeSchedule(
      recipeId: params.recipeId,
      recipeName: params.recipeName,
      start: params.start,
      end: params.end,
      color: params.color,
      isAllDay: params.isAllDay,
    );

    recipeScheduleBox.add(recipeScheduleModel);

    return 'Successfully Created!';
  }

  @override
  Future<List<RecipeSchedule>> fetchRecipeSchedules() async {
    // recipeScheduleBox.deleteAll(recipeScheduleBox.keys);
    return recipeScheduleBox.values.toList();
  }

  @override
  Future<LinkedHashMap<DateTime, List<RecipeSchedule>>>
      fetchRecipeScheduleLinkedHashmap() async {
    if (recipeScheduleBox.isEmpty) {
      throw CacheException();
    }

    final scheduleLinkedHashMap = LinkedHashMap<DateTime, List<RecipeSchedule>>(
      equals: isSameDay,
      hashCode: getHashCode,
    );

    // final Map<DateTime, List<RecipeScheduleModel>> scheduleMap = {};

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
