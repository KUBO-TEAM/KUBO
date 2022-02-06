import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kubo/core/models/schedule.hive.dart';
import 'package:kubo/modules/meal_plan/models/recipe.dart';
import 'package:kubo/modules/menu/bloc/menu_repository.dart';
import 'package:kubo/modules/menu/models/schedule.model.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  final MenuRepository menuRepository;

  MenuCubit({required this.menuRepository}) : super(MenuInitial());

  void fetchSchedules() {
    menuRepository.fetchSchedules().then((scheduleBox) {
      final List<Schedule> schedules = [];

      if (scheduleBox == null) {
        emit(MenuLoaded(schedules: schedules));
        return;
      }

      if (scheduleBox.isEmpty == false) {
        for (var element in scheduleBox.values) {
          schedules.add(
            Schedule(
              recipeId: element.recipeId,
              recipeName: element.recipeName,
              recipeDescription: element.recipeDescription,
              recipeImageUrl: element.recipeImageUrl,
              start: element.startTime,
              end: element.endTime,
              backgroundColor: element.color,
            ),
          );
        }

        emit(MenuLoaded(schedules: schedules));
      }
    });
  }

  void addSchedule({
    required Recipe recipe,
    required TimeOfDay start,
    required TimeOfDay end,
    required int day,
    required Color colorPicked,
  }) {
    final currentState = state;

    if (currentState is MenuLoaded) {
      List<Schedule> schedules = currentState.schedules;

      Schedule newSchedule = menuRepository.addAndReturnSchedule(
        recipe: recipe,
        start: start,
        end: end,
        day: day,
        colorPicked: colorPicked,
      );

      schedules.add(newSchedule);

      emit(MenuLoaded(schedules: schedules));
    }
  }

  void updateSchedule({
    required ScheduleHive schedule,
    required Recipe recipe,
    required TimeOfDay start,
    required TimeOfDay end,
    required int day,
    required Color colorPicked,
  }) {
    menuRepository.updateAndReturnSchedule(
      schedule: schedule,
      recipe: recipe,
      start: start,
      end: end,
      day: day,
      colorPicked: colorPicked,
    );

    // Temporary
    fetchSchedules();
  }
}
