import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_recipe.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_recipe_schedules.dart';

part 'menu_event.dart';
part 'menu_state.dart';

@injectable
class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final FetchRecipeSchedules fetchRecipeSchedules;
  final FetchRecipe fetchRecipe;

  MenuBloc({
    required this.fetchRecipeSchedules,
    required this.fetchRecipe,
  }) : super(MenuInitial()) {
    on<MenuEvent>((event, emit) async {
      if (event is MenuRecipeScheduleFetched) {
        emit(const MenuRecipeScheduleFetchInProgress());

        final failureOrRecipeFetched = await fetchRecipeSchedules(NoParams());

        await failureOrRecipeFetched.fold((failure) {
          emit(
            const MenuRecipeScheduleFetchFailure(
              message: 'Recipe fetched fails',
            ),
          );
        }, (recipeSchedules) async {
          emit(
            MenuRecipeScheduleFetchSuccess(recipeSchedules: recipeSchedules),
          );

          emit(
            MenuRecipeScheduleFetchInProgress(recipeSchedules: recipeSchedules),
          );

          for (RecipeSchedule recipeSchedule in recipeSchedules) {
            final failureOrRecipe = await fetchRecipe(recipeSchedule.recipe.id);

            await failureOrRecipe.fold(
              (l) {},
              (recipe) async {
                if (recipe != recipeSchedule.recipe) {
                  recipeSchedule.recipe = recipe;
                  await recipeSchedule.save();
                }
              },
            );
          }
          emit(
            MenuRecipeScheduleFetchSuccess(recipeSchedules: recipeSchedules),
          );
        });
      }
    });
  }
}
