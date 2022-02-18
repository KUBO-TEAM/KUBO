import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/core/error/error_messages.dart';
import 'package:kubo/core/helpers/date_converter.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_recipe_schedule_list.dart';
import 'package:kubo/features/food_planner/presentation/blocs/menu_history/menu_history_bloc.dart';

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
        if (event is MenuTimeTableCellPressed) {
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
        } else if (event is MenuRecipeScheduleListFetched) {
          emit(MenuInProgress());
          final failureOrListOfRecipeSchedules =
              await fetchRecipeScheduleList(NoParams());

          failureOrListOfRecipeSchedules.fold((failure) {
            emit(MenuFailure(mapFailureToMessage(failure)));
          }, (listOfRecipeSchedules) {
            emit(MenuSuccess(recipeSchedules: listOfRecipeSchedules));
          });
        }
      },
    );
  }
}
