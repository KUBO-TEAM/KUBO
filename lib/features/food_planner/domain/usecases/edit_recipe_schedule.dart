import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/repositories/recipe_schedule_repository.dart';

@lazySingleton
class EditRecipeSchedule
    implements UseCase<EditRecipeScheduleResponse, RecipeSchedule> {
  final RecipeScheduleRepository repository;

  EditRecipeSchedule(this.repository);

  @override
  Future<Either<Failure, EditRecipeScheduleResponse>> call(
    RecipeSchedule params,
  ) async {
    return await repository.editRecipeSchedule(params);
  }
}

class EditRecipeScheduleResponse extends Equatable {
  final String message;

  const EditRecipeScheduleResponse({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
