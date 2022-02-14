import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/repositories/recipe_schedule_repository.dart';

@lazySingleton
class CreateRecipeSchedule implements UseCase<RecipeSchedule, Params> {
  final RecipeScheduleRepository repository;

  CreateRecipeSchedule(this.repository);

  @override
  Future<Either<Failure, RecipeSchedule>> call(Params params) async {
    return await repository.createRecipeSchedule(
      id: params.id,
      name: params.name,
      description: params.description,
      imageUrl: params.imageUrl,
      start: params.start,
      end: params.end,
      color: params.color,
      isAllDay: params.isAllDay,
    );
  }
}

class Params extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final DateTime start;
  final DateTime end;
  final Color color;
  final bool isAllDay;

  const Params({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.start,
    required this.end,
    required this.color,
    this.isAllDay = false,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        start,
        end,
        color,
        isAllDay,
      ];
}
