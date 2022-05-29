import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/repositories/recipe_schedule_repository.dart';

@lazySingleton
class FetchRecipeSchedulesLength implements UseCase<int, NoParams> {
  final RecipeScheduleRepository repository;

  FetchRecipeSchedulesLength(this.repository);

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    return await repository.fetchRecipeSchedulesLength();
  }
}
