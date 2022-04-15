import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/data/models/recipe_model.dart';
import 'package:kubo/features/food_planner/domain/repositories/recipe_repository.dart';

@lazySingleton
class FetchRecipes implements UseCase<List<RecipeModel>, NoParams> {
  final RecipeRepository repository;

  FetchRecipes(this.repository);

  @override
  Future<Either<Failure, List<RecipeModel>>> call(NoParams params) async {
    return await repository.fetchRecipes();
  }
}