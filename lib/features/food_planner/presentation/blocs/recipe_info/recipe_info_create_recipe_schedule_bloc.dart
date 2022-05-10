import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/helpers/date_converter.dart';
import 'package:kubo/core/helpers/notification_reminder.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
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

            await failureOrRecipeIsCreated.fold((failureMessage) {
              emit(
                const RecipeInfoCreateRecipeScheduleFailure(
                  message: 'Failed to create recipe schedule',
                ),
              );
            }, (successMessage) async {
              var box = await Hive.openBox('Notification scheduled id box');

              if (box.get('notification id') == null) {
                box.put('notification id', 0);
              }

              // The real schedule
              _scheduleNotification(
                id: box.get('notification id'),
                startingDate: convertedDates.start,
                timeToSubstract: Duration.zero,
                recipe: recipe,
                title: 'Upcoming recipe',
                message:
                    'Your scheduled recipe is ready, please prepare it now.',
              );

              box.put('notification id', box.get('notification id') + 1);

              // 15 minutes before
              _scheduleNotification(
                id: box.get('notification id'),
                startingDate: convertedDates.start,
                recipe: recipe,
                timeToSubstract: const Duration(minutes: 15),
                title: 'Upcoming recipe',
                message: '15 minutes before the latest scheduled recipe.',
              );
              box.put('notification id', box.get('notification id') + 1);

              // 30 minutes before
              _scheduleNotification(
                id: box.get('notification id'),
                startingDate: convertedDates.start,
                recipe: recipe,
                timeToSubstract: const Duration(minutes: 30),
                title: 'Upcoming recipe',
                message: '39 minutes before the latest scheduled recipe.',
              );
              box.put('notification id', box.get('notification id') + 1);

              // 1 hour before
              _scheduleNotification(
                id: box.get('notification id'),
                startingDate: convertedDates.start,
                recipe: recipe,
                timeToSubstract: const Duration(hours: 1),
                title: 'Upcoming recipe',
                message: '1 hour before the latest scheduled recipe.',
              );
              box.put('notification id', box.get('notification id') + 1);

              await box.close();

              emit(
                RecipeInfoCreateRecipeScheduleSuccess(
                  message: successMessage,
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
