import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_latest_recipe.dart';

part 'recipe_updates_event.dart';
part 'recipe_updates_state.dart';

@injectable
class RecipeUpdatesBloc extends Bloc<RecipeUpdatesEvent, RecipeUpdatesState> {
  final FetchLatestRecipe fetchLatestRecipe;

  RecipeUpdatesBloc({
    required this.fetchLatestRecipe,
  }) : super(RecipeUpdatesInitial()) {
    on<RecipeUpdatesEvent>((event, emit) async {
      if (event is RecipeUpdatesLatestRecipeFetched) {
        final failureOrLatestRecipe = await fetchLatestRecipe(NoParams());

        failureOrLatestRecipe.fold((failure) {}, (recipe) {
          emit(RecipeUpdatesSuccess(recipe: recipe));
        });
      }
    });
  }
}
