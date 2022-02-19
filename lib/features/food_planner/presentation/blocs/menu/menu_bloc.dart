import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/error_messages.dart';
import 'package:kubo/core/helpers/date_converter.dart';
import 'package:kubo/core/hive/objects/recipe_schedule_hive.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/data/models/recipe_schedule_model.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_recipe_schedule_list.dart';

part 'menu_event.dart';
part 'menu_state.dart';

@injectable
class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final CreateRecipeSchedule createRecipeSchedule;
  final FetchRecipeScheduleList fetchRecipeScheduleList;

  final DateConverter dateConverter;

  MenuBloc({
    required this.createRecipeSchedule,
    required this.fetchRecipeScheduleList,
    required this.dateConverter,
  }) : super(MenuInitial()) {
    on<MenuEvent>(
      (event, emit) async {
        if (event is MenuTimeTableRecipeScheduleAdded) {
          await _menuTimeTableRecipeScheduleAdded(emit, event);
        } else if (event is MenuRecipeScheduleListFetched) {
          await _menuRecipeScheduleListFetched(emit);
        } else if (event is MenuRecipeScheduleListUpdated) {
          if (state is MenuSuccess) {
            final recipeSchedules = (state as MenuSuccess).recipeSchedules;

            emit(MenuInProgress());

            final updateRecipeSchedule = RecipeScheduleModel(
              id: event.updatedRecipeScheduleHive.id,
              name: event.updatedRecipeScheduleHive.name,
              description: event.updatedRecipeScheduleHive.description,
              imageUrl: event.updatedRecipeScheduleHive.imageUrl,
              start: event.updatedRecipeScheduleHive.start,
              end: event.updatedRecipeScheduleHive.end,
              color: event.updatedRecipeScheduleHive.color,
              isAllDay: false,
            );

            final index = recipeSchedules.indexWhere(
              (value) => event.updatedRecipeScheduleHive.id == value.id,
            );

            if (index != -1) {
              recipeSchedules[index] = updateRecipeSchedule;
              emit(MenuSuccess(recipeSchedules: recipeSchedules));
            }
          }
        }
      },
    );
  }

  Future<void> _menuRecipeScheduleListFetched(Emitter<MenuState> emit) async {
    emit(MenuInProgress());
    final failureOrListOfRecipeSchedules =
        await fetchRecipeScheduleList(NoParams());

    failureOrListOfRecipeSchedules.fold((failure) {
      emit(MenuFailure(mapFailureToMessage(failure)));
    }, (listOfRecipeSchedules) {
      emit(MenuSuccess(recipeSchedules: listOfRecipeSchedules));
    });
  }

  Future<void> _menuTimeTableRecipeScheduleAdded(
      Emitter<MenuState> emit, MenuTimeTableRecipeScheduleAdded event) async {
    List<RecipeSchedule> recipeSchedules = [];

    final currentState = state;

    if (currentState is MenuSuccess) {
      recipeSchedules = currentState.recipeSchedules;
    }

    emit(MenuInProgress());

    final convertDates = dateConverter.convertStartAndEndTimeOfDay(
      day: event.day,
      startTimeOfDay: event.start,
      endTimeOfDay: event.end,
    );

    await convertDates.fold((failure) {
      emit(
        MenuFailure(
          mapFailureToMessage(failure),
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
        emit(MenuFailure(mapFailureToMessage(failure)));
      }, (recipeSchedule) async {
        recipeSchedules.add(recipeSchedule);

        emit(MenuSuccess(recipeSchedules: recipeSchedules));
      });
    });
  }
}
