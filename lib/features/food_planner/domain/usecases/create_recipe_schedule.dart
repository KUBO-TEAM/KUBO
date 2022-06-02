import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/domain/repositories/recipe_schedule_repository.dart';

@lazySingleton
class CreateRecipeSchedule
    implements UseCase<CreateRecipeScheduleResponse, CreateRecipeParams> {
  final RecipeScheduleRepository repository;

  CreateRecipeSchedule(this.repository);

  @override
  Future<Either<Failure, CreateRecipeScheduleResponse>> call(
    CreateRecipeParams params,
  ) async {
    return await repository.createRecipeSchedule(params);
  }
}

class CreateRecipeScheduleResponse extends Equatable {
  final String message;

  const CreateRecipeScheduleResponse({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class CreateRecipeParams extends Equatable {
  final Recipe recipe;
  final DateTime start;
  final DateTime end;
  final Color color;
  final bool isAllDay;
  final int notificationStartId;

  const CreateRecipeParams({
    required this.recipe,
    required this.start,
    required this.end,
    required this.color,
    required this.isAllDay,
    required this.notificationStartId,
  });

  @override
  List<Object?> get props => [
        recipe,
        start,
        end,
        color,
        isAllDay,
        notificationStartId,
      ];
}
