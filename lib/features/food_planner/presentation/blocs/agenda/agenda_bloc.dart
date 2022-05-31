import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_recipe.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_recipe_schedules.dart';

part 'agenda_event.dart';
part 'agenda_state.dart';

@injectable
class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  final FetchRecipeSchedules fetchRecipeSchedules;
  final FetchRecipe fetchRecipe;

  AgendaBloc({
    required this.fetchRecipeSchedules,
    required this.fetchRecipe,
  }) : super(AgendaInitial()) {
    on<AgendaEvent>((event, emit) async {
      if (event is AgendaRecipeSchedulesFetched) {
        final failureOrRecipeSchedules = await fetchRecipeSchedules(NoParams());

        await failureOrRecipeSchedules.fold((failure) {
          emit(const AgendaFetchFailure(message: 'Fails to fetch agenda!'));
        }, (recipeSchedules) async {
          emit(AgendaFetchSuccess(recipeSchedules: recipeSchedules));

          bool isSomethingFail = false;

          for (RecipeSchedule recipeSchedule in recipeSchedules) {
            final failureOrRecipe = await fetchRecipe(recipeSchedule.recipe.id);

            failureOrRecipe.fold(
              (failure) {
                isSomethingFail = true;
              },
              (recipe) async {
                if (recipe != recipeSchedule.recipe) {
                  recipeSchedule.recipe = recipe;
                  await recipeSchedule.save();
                }
              },
            );
          }
          if (isSomethingFail) {
            emit(
              AgendaUpdateFetchFailure(
                message: 'No internet connection',
                recipeSchedules: recipeSchedules,
              ),
            );
          } else {
            emit(
              AgendaUpdateFetchSuccess(
                recipeSchedules: recipeSchedules,
              ),
            );
          }
        });
      }
    });
  }
}
