import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/data/models/recipe_model.dart';
import 'package:kubo/features/food_planner/domain/entities/category.dart';
import 'package:kubo/features/food_planner/domain/repositories/recipe_repository.dart';

@lazySingleton
class FetchFilteredRecipes
    implements UseCase<List<RecipeModel>, List<Category>> {
  final RecipeRepository repository;

  FetchFilteredRecipes(this.repository);

  @override
  Future<Either<Failure, List<RecipeModel>>> call(List<Category> params) async {
    return await repository.fetchFilteredRecipes(params);
  }
}
