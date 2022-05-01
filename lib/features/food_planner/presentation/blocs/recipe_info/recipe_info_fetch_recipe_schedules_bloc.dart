import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_recipe_schedules.dart';

part 'recipe_info_fetch_recipe_schedules_event.dart';
part 'recipe_info_fetch_recipe_schedules_state.dart';

@injectable
class RecipeInfoFetchRecipeSchedulesBloc extends Bloc<
    RecipeInfoFetchRecipeSchedulesEvent, RecipeInfoFetchRecipeSchedulesState> {
  final FetchRecipeSchedules fetchRecipeSchedules;

  RecipeInfoFetchRecipeSchedulesBloc({required this.fetchRecipeSchedules})
      : super(RecipeInfoFetchRecipeSchedulesInitial()) {
    on<RecipeInfoFetchRecipeSchedulesEvent>((event, emit) async {
      if (event is RecipeInfoFetchRecipeSchedulesFetched) {
        emit(RecipeInfoFetchRecipeSchedulesInProgress());

        final failureOrRecipeSchedules = await fetchRecipeSchedules(NoParams());

        failureOrRecipeSchedules.fold((failure) {
          emit(
            const RecipeInfoFetchRecipeSchedulesFailure(
              message: 'Cannot fetch recipe schedules',
            ),
          );
        }, (recipeSchedules) {
          emit(
            RecipeInfoFetchRecipeSchedulesSuccess(
              recipeSchedules: recipeSchedules,
            ),
          );
        });
      }
    });
  }
}
