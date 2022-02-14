import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/core/error/error_messages.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_recipe_schedule.dart';

part 'recipe_schedule_event.dart';
part 'recipe_schedule_state.dart';

class RecipeScheduleBloc
    extends Bloc<RecipeScheduleEvent, RecipeScheduleState> {
  final CreateRecipeSchedule createRecipeSchedule;

  RecipeScheduleBloc({required this.createRecipeSchedule}) : super(Empty()) {
    on<RecipeScheduleEvent>(
      (event, emit) async {
        if (event is CreateRecipeScheduleForMenu) {
          emit(Loading());

          final failureOrRecipeSchedule = await createRecipeSchedule(
            Params(
              id: event.id,
              name: event.name,
              description: event.description,
              imageUrl: event.imageUrl,
              start: event.start,
              end: event.end,
              color: event.color,
            ),
          );

          failureOrRecipeSchedule.fold((failure) {
            emit(Error(_mapFailureToMessage(failure)));
          }, (recipeSchedule) {
            emit(Loaded(recipeSchedule: recipeSchedule));
          });
        }
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_FAILURE_MESSAGE;
    }
  }
}
