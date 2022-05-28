import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';
import 'package:kubo/features/smart_recipe_selection/domain/repositories/smart_recipe_selection_repository.dart';

@lazySingleton
class GenerateRecipeSchedules
    implements UseCase<List<RecipeSchedule>, List<Category>> {
  final SmartRecipeSelectionRepository repository;

  GenerateRecipeSchedules(this.repository);

  @override
  Future<Either<Failure, List<RecipeSchedule>>> call(
      List<Category> categories) async {
    return await repository.generateRecipeSchedules(categories);
  }
}
