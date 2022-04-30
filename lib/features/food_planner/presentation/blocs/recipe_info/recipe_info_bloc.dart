import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/helpers/date_converter.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_recipe_schedule.dart';

part 'recipe_info_event.dart';
part 'recipe_info_state.dart';

@injectable
class RecipeInfoBloc extends Bloc<RecipeInfoEvent, RecipeInfoState> {
  final CreateRecipeSchedule createRecipeSchedule;
  final DateConverter dateConverter;

  RecipeInfoBloc({
    required this.createRecipeSchedule,
    required this.dateConverter,
  }) : super(RecipeInfoInitial()) {
    on<RecipeInfoEvent>((event, emit) async {
      if (event is RecipeInfoRecipeScheduleCreated) {
        emit(RecipeInfoCreateRecipeScheduleInProgress());

        final recipe = event.recipe;
        final start = event.start;
        final end = event.end;
        final color = event.color;
        final day = event.day;

        if (recipe != null &&
            day != null &&
            start != null &&
            end != null &&
            color != null) {
          final convertDates = dateConverter.convertStartAndEndTimeOfDay(
            day: day,
            startTimeOfDay: start,
            endTimeOfDay: end,
          );

          await convertDates.fold((failure) {
            emit(const RecipeInfoCreateRecipeScheduleFailure(
              message: 'Failed to create recipe schedule',
            ));
          }, (convertedDates) async {
            final createRecipeParams = CreateRecipeParams(
              recipe: recipe,
              start: convertedDates.start,
              end: convertedDates.end,
              color: color,
              isAllDay: false,
            );

            final failureOrRecipeIsCreated =
                await createRecipeSchedule(createRecipeParams);

            failureOrRecipeIsCreated.fold((failureMessage) {
              emit(const RecipeInfoCreateRecipeScheduleFailure(
                message: 'Failed to create recipe schedule',
              ));
            }, (successMessage) {
              emit(RecipeInfoCreateRecipeScheduleSuccess(
                  message: successMessage));
            });
          });
        }
      }
    });
  }
}
