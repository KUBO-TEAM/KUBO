import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/helpers/date_converter.dart';
import 'package:kubo/core/helpers/notification_reminder.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
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

              failureOrEditRecipeScheduleResponse.fold(
                (failure) {
                  emit(
                    const RecipeScheduleEditFailure(
                      message: 'Failed to edit schedule',
                    ),
                  );
                },
                (response) {
                  _editScheduleNotification(recipeSchedule);
                  emit(RecipeScheduleEditSuccess(message: response.message));
                },
              );
            },
          );
        }
      }
    });
  }

  void _editScheduleNotification(RecipeSchedule recipeSchedule) {
    int notificationId = recipeSchedule.notificationStartId;

    _scheduleNotification(
      id: notificationId,
      startingDate: recipeSchedule.start,
      timeToSubstract: Duration.zero,
      recipe: recipeSchedule.recipe,
      title: 'Upcoming recipe',
      message: 'Your scheduled recipe is ready, please prepare it now.',
    );

    notificationId++;

    _scheduleNotification(
      id: notificationId,
      startingDate: recipeSchedule.start,
      timeToSubstract: const Duration(hours: 1),
      recipe: recipeSchedule.recipe,
      title: 'Upcoming recipe',
      message: '1 hour before the latest scheduled recipe.',
    );

    notificationId++;

    _scheduleNotification(
      id: notificationId,
      startingDate: recipeSchedule.start,
      timeToSubstract: const Duration(minutes: 30),
      recipe: recipeSchedule.recipe,
      title: 'Upcoming recipe',
      message: '30 minutes before the latest scheduled recipe.',
    );

    notificationId++;

    _scheduleNotification(
      id: notificationId,
      startingDate: recipeSchedule.start,
      timeToSubstract: const Duration(minutes: 15),
      recipe: recipeSchedule.recipe,
      title: 'Upcoming recipe',
      message: '15 minutes before the latest scheduled recipe.',
    );
  }

  void _scheduleNotification({
    required int id,
    required DateTime startingDate,
    required Recipe recipe,
    required Duration timeToSubstract,
    required String title,
    required String message,
  }) {
    final defferenceStartingDate = startingDate.subtract(timeToSubstract);

    if (defferenceStartingDate.isAfter(DateTime.now())) {
      NotificationReminder.showScheduledNotification(
        id: id,
        title: title,
        body: message,
        payload: recipe.name,
        largeIconUrl: 'https://kuboph.dev/assets/logo.ico',
        bigPictureUrl: recipe.displayPhoto,
        scheduledDate: defferenceStartingDate,
      );
    }
  }
}
