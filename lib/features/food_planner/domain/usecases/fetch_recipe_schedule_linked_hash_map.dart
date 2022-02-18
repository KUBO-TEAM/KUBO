import 'dart:collection';

import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/repositories/recipe_schedule_repository.dart';

@lazySingleton
class FetchRecipeScheduleLinkedHashMap
    implements
        UseCase<LinkedHashMap<DateTime, List<RecipeSchedule>>, NoParams> {
  final RecipeScheduleRepository repository;

  FetchRecipeScheduleLinkedHashMap(this.repository);

  @override
  Future<Either<Failure, LinkedHashMap<DateTime, List<RecipeSchedule>>>> call(
    NoParams params,
  ) async {
    return await repository.fetchRecipeScheduleLinkedHashmap();
  }
}
