import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/repositories/recipe_schedule_repository.dart';

class GetAllRecipeSchedule implements UseCase<List<RecipeSchedule>, NoParams> {
  final RecipeScheduleRepository repository;

  GetAllRecipeSchedule(this.repository);

  @override
  Future<Either<Failure, List<RecipeSchedule>>> call(NoParams params) async {
    return await repository.getAllRecipeSchedule();
  }
}
