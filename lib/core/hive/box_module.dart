import 'package:injectable/injectable.dart';
import 'package:kubo/features/food_planner/data/datasources/recipe_local_data_source.dart';
import 'package:kubo/features/food_planner/data/datasources/recipe_schedule_local_data_source.dart';
import 'package:hive/hive.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';

@module
abstract class BoxModule {
  @preResolve
  Future<Box<RecipeSchedule>> get recipeSchedule =>
      Hive.openBox(kRecipeScheduleBoxKey);

  @preResolve
  Future<Box<Recipe>> get recipe => Hive.openBox(kRecipeBoxKey);
}
