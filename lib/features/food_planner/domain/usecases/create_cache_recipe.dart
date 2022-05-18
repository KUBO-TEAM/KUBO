import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/domain/repositories/recipe_repository.dart';

@lazySingleton
class CreateCacheRecipe
    implements UseCase<CreateCacheRecipeResponse, CreateCacheRecipeParams> {
  final RecipeRepository repository;

  CreateCacheRecipe(this.repository);

  @override
  Future<Either<Failure, CreateCacheRecipeResponse>> call(
    CreateCacheRecipeParams params,
  ) async {
    return await repository.createCacheRecipe(params);
  }
}

class CreateCacheRecipeParams extends Equatable {
  final List<Recipe> recipes;

  const CreateCacheRecipeParams({
    required this.recipes,
  });

  @override
  List<Object?> get props => [recipes];
}

class CreateCacheRecipeResponse extends Equatable {
  final String message;

  const CreateCacheRecipeResponse({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
