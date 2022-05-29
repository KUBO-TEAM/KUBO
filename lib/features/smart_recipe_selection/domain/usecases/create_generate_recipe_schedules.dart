import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/smart_recipe_selection/domain/repositories/smart_recipe_selection_repository.dart';

@lazySingleton
class CreateGenerateRecipeSchedules
    implements
        UseCase<CreateGenerateRecipeSchedulesResponse, List<RecipeSchedule>> {
  final SmartRecipeSelectionRepository repository;

  CreateGenerateRecipeSchedules(this.repository);

  @override
  Future<Either<Failure, CreateGenerateRecipeSchedulesResponse>> call(
      List<RecipeSchedule> recipeSchedules) async {
    return await repository.createGenerateRecipeSchedules(recipeSchedules);
  }
}

class CreateGenerateRecipeSchedulesResponse extends Equatable {
  final String message;

  const CreateGenerateRecipeSchedulesResponse({required this.message});

  @override
  List<Object?> get props => [message];
}
