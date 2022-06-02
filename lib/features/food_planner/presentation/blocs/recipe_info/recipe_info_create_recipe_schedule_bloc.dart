import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/helpers/date_converter.dart';
import 'package:kubo/core/helpers/notification_reminder.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/domain/entities/user.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_recipe_schedule.dart';

part 'recipe_info_create_recipe_schedule_event.dart';
part 'recipe_info_create_recipe_schedule_state.dart';

@injectable
class RecipeInfoCreateRecipeScheduleBloc extends Bloc<
    RecipeInfoCreateRecipeScheduleEvent, RecipeInfoCreateRecipeScheduleState> {
  final CreateRecipeSchedule createRecipeSchedule;
  final DateConverter dateConverter;

  RecipeInfoCreateRecipeScheduleBloc({
    required this.createRecipeSchedule,
    required this.dateConverter,
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
              _scheduleNotification(
                id: user.notificationChannelIdCounter,
                startingDate: convertedDates.start,
                timeToSubstract: Duration.zero,
                recipe: recipe,
                title: 'Upcoming recipe',
                message:
                    'Your scheduled recipe is ready, please prepare it now.',
              );

              user.notificationChannelIdCounter++;

              _scheduleNotification(
                id: user.notificationChannelIdCounter,
                startingDate: convertedDates.start,
                timeToSubstract: const Duration(hours: 1),
                recipe: recipe,
                title: 'Upcoming recipe',
                message: '1 hour before the latest scheduled recipe.',
              );

              user.notificationChannelIdCounter++;

              _scheduleNotification(
                id: user.notificationChannelIdCounter,
                startingDate: convertedDates.start,
                timeToSubstract: const Duration(minutes: 30),
                recipe: recipe,
                title: 'Upcoming recipe',
                message: '30 minutes before the latest scheduled recipe.',
              );

              user.notificationChannelIdCounter++;

              _scheduleNotification(
                id: user.notificationChannelIdCounter,
                startingDate: convertedDates.start,
                timeToSubstract: const Duration(minutes: 15),
                recipe: recipe,
                title: 'Upcoming recipe',
                message: '15 minutes before the latest scheduled recipe.',
              );

              user.notificationChannelIdCounter++;

              await user.save();

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
