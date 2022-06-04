import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/helpers/date_converter.dart';
import 'package:kubo/core/helpers/utils.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/domain/entities/user.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_recipe_schedule_reminder.dart';

part 'recipe_info_create_recipe_schedule_event.dart';
part 'recipe_info_create_recipe_schedule_state.dart';

@injectable
class RecipeInfoCreateRecipeScheduleBloc extends Bloc<
    RecipeInfoCreateRecipeScheduleEvent, RecipeInfoCreateRecipeScheduleState> {
  final CreateRecipeSchedule createRecipeSchedule;
  final DateConverter dateConverter;
  final CreateRecipeScheduleReminder createRecipeScheduleReminder;

  RecipeInfoCreateRecipeScheduleBloc({
    required this.createRecipeSchedule,
    required this.dateConverter,
    required this.createRecipeScheduleReminder,
  }) : super(RecipeInfoCreateRecipeScheduleInitial()) {
    on<RecipeInfoCreateRecipeScheduleEvent>((event, emit) async {
      if (event is RecipeInfoCreateRecipeScheduleCreated) {
        emit(
          RecipeInfoCreateRecipeScheduleInProgress(),
        );

        final recipe = event.recipe;
        final start = event.start;
        final end = event.end;
        final color = event.color;
        final day = event.day;
        User user = event.user;

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
            emit(
              RecipeInfoCreateRecipeScheduleFailure(
                message: failure.message,
              ),
            );
          }, (convertedDates) async {
            final createRecipeParams = CreateRecipeParams(
              recipe: recipe,
              start: convertedDates.start,
              end: convertedDates.end,
              color: color,
              isAllDay: false,
              notificationStartId: user.notificationChannelIdCounter,
            );

            final failureOrRecipeIsCreated =
                await createRecipeSchedule(createRecipeParams);

            await failureOrRecipeIsCreated.fold((failureMessage) {
              emit(
                const RecipeInfoCreateRecipeScheduleFailure(
                  message: 'Failed to create recipe schedule',
                ),
              );
            }, (response) async {
              await Utils.scheduleNotificationWithUser(
                start: convertedDates.start,
                recipe: recipe,
                user: user,
              );

              // Create recipe Schedule Reminder
              await createRecipeScheduleReminder(response.recipeSchedule);

              emit(
                RecipeInfoCreateRecipeScheduleSuccess(
                  message: response.message,
                ),
              );
            });
          });
        }
      }
    });
  }
}
