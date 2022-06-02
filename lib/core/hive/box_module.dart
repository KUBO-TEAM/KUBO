import 'package:injectable/injectable.dart';
import 'package:hive/hive.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/entities/reminder.dart';
import 'package:kubo/features/food_planner/domain/entities/user.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';

@module
abstract class BoxModule {
  @preResolve
  Future<Box<RecipeSchedule>> get recipeSchedule =>
      Hive.openBox(kRecipeScheduleBoxKey);

  @preResolve
  Future<Box<Recipe>> get recipe => Hive.openBox(kRecipeBoxKey);

  @preResolve
  Future<Box<Reminder>> get reminder => Hive.openBox(kReminderBoxKey);
  @preResolve
  Future<Box<User>> get user => Hive.openBox(kUserBoxKey);

  @preResolve
  Future<Box<Category>> get category => Hive.openBox(kCategoryBoxKey);
  @preResolve
  Future<Box<PredictedImage>> get predictedImage => Hive.openBox(
        kPredictedImageBoxKey,
      );
}
