import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/repositories/recipe_schedule_repository.dart';

@lazySingleton
class DeleteRecipeSchedule
    implements UseCase<DeleteRecipeScheduleResponse, RecipeSchedule> {
  final RecipeScheduleRepository repository;

  DeleteRecipeSchedule(this.repository);

  @override
  Future<Either<Failure, DeleteRecipeScheduleResponse>> call(
    RecipeSchedule params,
  ) async {
    return await repository.deleteRecipeSchedule(params);
  }
}

class DeleteRecipeScheduleResponse extends Equatable {
  final String message;

  const DeleteRecipeScheduleResponse({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
