import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/core/error/error_messages.dart';
import 'package:kubo/core/helpers/date_converter.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_recipe_schedule.dart';

part 'recipe_schedule_event.dart';
part 'recipe_schedule_state.dart';

@injectable
class RecipeScheduleBloc
    extends Bloc<RecipeScheduleEvent, RecipeScheduleState> {
  final CreateRecipeSchedule createRecipeSchedule;
  final DateConverter dateConverter;

  RecipeScheduleBloc(
      {required this.createRecipeSchedule, required this.dateConverter})
      : super(Empty()) {
    on<RecipeScheduleEvent>(
      (event, emit) async {
        if (event is CreateRecipeScheduleForMenu) {
          emit(Loading());

          final convertDates = dateConverter.convertStartAndEndTimeOfDay(
            day: event.day,
            startTimeOfDay: event.start,
            endTimeOfDay: event.end,
          );

          await convertDates.fold((failure) {
            emit(
              Error(
                _mapFailureToMessage(failure),
              ),
            );
          }, (convertedDates) async {
            final failureOrRecipeSchedule = await createRecipeSchedule(
              Params(
                id: event.id,
                name: event.name,
                description: event.description,
                imageUrl: event.imageUrl,
                start: convertedDates.start,
                end: convertedDates.end,
                color: event.color,
              ),
            );

            await failureOrRecipeSchedule.fold((failure) async {
              emit(Error(_mapFailureToMessage(failure)));
            }, (recipeSchedule) async {
              emit(Loaded(recipeSchedules: [recipeSchedule]));
            });
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
      case DateConverterFailure:
        return DATE_CONVERTER_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_FAILURE_MESSAGE;
    }
  }
}
