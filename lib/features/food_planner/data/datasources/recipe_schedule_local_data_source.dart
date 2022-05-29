import 'dart:collection';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/core/helpers/menu_linked_hashmap.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_recipe_schedule.dart';

abstract class RecipeScheduleLocalDataSource {
  /// create [RecipeScheduleModel] to the cached.
  ///
  /// Throws [CacheException] if data is not save.
  ///
  Future<CreateRecipeScheduleResponse> createRecipeSchedule(
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

  Future<RecipeSchedule?> fetchTodayRecipeSchedule();

  Future<RecipeSchedule?> fetchTomorrowRecipeSchedule();

  Future<int> fetchRecipeSchedulesLength();
}

@LazySingleton(as: RecipeScheduleLocalDataSource)
class RecipeScheduleLocalDataSourceImpl
    implements RecipeScheduleLocalDataSource {
  final Box<RecipeSchedule> recipeScheduleBox;

  RecipeScheduleLocalDataSourceImpl({required this.recipeScheduleBox});

  @override
  Future<CreateRecipeScheduleResponse> createRecipeSchedule(
    CreateRecipeParams params,
  ) async {
    final recipeScheduleModel = RecipeSchedule(
      recipe: params.recipe,
      start: params.start,
      end: params.end,
      color: params.color,
      isAllDay: params.isAllDay,
      createdAt: DateTime.now(),
    );

    recipeScheduleBox.add(recipeScheduleModel);

    return const CreateRecipeScheduleResponse(message: 'Successfully Created!');
  }

  @override
  Future<List<RecipeSchedule>> fetchRecipeSchedules() async {
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

    final Map<DateTime, List<RecipeSchedule>> scheduleMap = {};

    for (var recipeSchedule in recipeScheduleBox.values) {
      final key = DateTime(
        recipeSchedule.start.year,
        recipeSchedule.start.month,
        recipeSchedule.start.day,
      );

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

  @override
  Future<RecipeSchedule?> fetchTodayRecipeSchedule() async {
    final recipeSchedules = recipeScheduleBox.values.toList();

    final currentDate = DateTime.now();

    final tomorrowDate = currentDate.add(
      const Duration(
        days: 1,
      ),
    );

    final startingHourOfTommorow = DateTime(
      tomorrowDate.year,
      tomorrowDate.month,
      tomorrowDate.day,
      0,
      0,
    );

    RecipeSchedule? latestSchedule;

    for (RecipeSchedule recipeSchedule in recipeSchedules) {
      final scheduleDate = recipeSchedule.start;

      if (scheduleDate.isAfter(currentDate) &&
          scheduleDate.isBefore(
            startingHourOfTommorow,
          )) {
        if (latestSchedule != null) {
          if (latestSchedule.start.isAfter(scheduleDate)) {
            latestSchedule = recipeSchedule;
          }
        } else {
          latestSchedule = recipeSchedule;
        }
      }
    }

    return latestSchedule;
  }

  @override
  Future<RecipeSchedule?> fetchTomorrowRecipeSchedule() async {
    final recipeSchedules = recipeScheduleBox.values.toList();

    final currentDate = DateTime.now();

    final tomorrowDate = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      11,
      59,
    );

    RecipeSchedule? latestSchedule;

    for (RecipeSchedule recipeSchedule in recipeSchedules) {
      final scheduleDate = recipeSchedule.start;

      if (scheduleDate.isAfter(tomorrowDate)) {
        if (latestSchedule != null) {
          if (latestSchedule.start.isAfter(scheduleDate)) {
            latestSchedule = recipeSchedule;
          }
        } else {
          latestSchedule = recipeSchedule;
        }
      }
    }
    return latestSchedule;
  }

  @override
  Future<int> fetchRecipeSchedulesLength() async {
    return recipeScheduleBox.values.length;
  }
}
