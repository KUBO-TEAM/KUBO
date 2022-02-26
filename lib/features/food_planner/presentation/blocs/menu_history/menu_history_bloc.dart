import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/error_messages.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_recipe_schedule_linked_hash_map.dart';

part 'menu_history_event.dart';
part 'menu_history_state.dart';

@injectable
class MenuHistoryBloc extends Bloc<MenuHistoryEvent, MenuHistoryState> {
  final FetchRecipeScheduleLinkedHashMap fetchRecipeScheduleLinkedHashMap;

  MenuHistoryBloc({required this.fetchRecipeScheduleLinkedHashMap})
      : super(MenuHistoryInitial()) {
    on<MenuHistoryEvent>((event, emit) async {
      if (event is MenuHistoryRecipeScheduleFetched) {
        emit(MenuHistoryInProgress());

        final failureOrRecipeSchedulesLinkedHashmap =
            await fetchRecipeScheduleLinkedHashMap(NoParams());

        failureOrRecipeSchedulesLinkedHashmap.fold((failure) {
          emit(MenuHistoryFailure(message: mapFailureToMessage(failure)));
        }, (recipeScheduleLinkedHashmap) {
          emit(MenuHistorySuccess(
            recipeScheduleLinkedHashmap: recipeScheduleLinkedHashmap,
          ));
        });
      }
    });
  }
}
