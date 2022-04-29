import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/repositories/recipe_schedule_repository.dart';

@lazySingleton
class CreateRecipeSchedule implements UseCase<String, CreateRecipeParams> {
  final RecipeScheduleRepository repository;

  CreateRecipeSchedule(this.repository);

  @override
  Future<Either<Failure, String>> call(
    CreateRecipeParams params,
  ) async {
    return await repository.createRecipeSchedule(params);
  }
}

class CreateRecipeParams extends Equatable {
  final String recipeId;
  final DateTime start;
  final DateTime end;
  final Color color;
  final bool isAllDay;

  const CreateRecipeParams({
    required this.recipeId,
    required this.start,
    required this.end,
    required this.color,
    required this.isAllDay,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        recipeId,
        start,
        end,
        color,
        isAllDay,
      ];
}
