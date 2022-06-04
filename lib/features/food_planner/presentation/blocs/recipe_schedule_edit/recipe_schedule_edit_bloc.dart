import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/helpers/date_converter.dart';
import 'package:kubo/core/helpers/utils.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/edit_recipe_schedule.dart';

part 'recipe_schedule_edit_event.dart';
part 'recipe_schedule_edit_state.dart';

@injectable
class RecipeScheduleEditBloc
    extends Bloc<RecipeScheduleEditEvent, RecipeScheduleEditState> {
  final EditRecipeSchedule editRecipeSchedule;
  final DateConverter dateConverter;

  RecipeScheduleEditBloc({
    required this.editRecipeSchedule,
    required this.dateConverter,
  }) : super(RecipeScheduleEditInitial()) {
    on<RecipeScheduleEditEvent>((event, emit) async {
      if (event is RecipeScheduleManualEdited) {
        final recipeSchedule = event.recipeSchedule;
        final start = event.start;
        final end = event.end;
        final color = event.color;
        final day = event.day;

        if (day != null && start != null && end != null && color != null) {
          final convertDates = dateConverter.convertStartAndEndTimeOfDay(
            day: day,
            startTimeOfDay: start,
            endTimeOfDay: end,
          );

          await convertDates.fold(
            (failure) {},
            (convertedDates) async {
              recipeSchedule.start = convertedDates.start;
              recipeSchedule.end = convertedDates.end;
              recipeSchedule.color = color;

              final failureOrEditRecipeScheduleResponse =
                  await editRecipeSchedule(recipeSchedule);

              await failureOrEditRecipeScheduleResponse.fold(
                (failure) {
                  emit(
                    const RecipeScheduleEditFailure(
                      message: 'Failed to edit schedule',
                    ),
                  );
                },
                (response) async {
                  await Utils.scheduleNotification(
                    recipeSchedule: recipeSchedule,
                  );
                  emit(RecipeScheduleEditSuccess(message: response.message));
                },
              );
            },
          );
        }
      }
    });
  }
}
