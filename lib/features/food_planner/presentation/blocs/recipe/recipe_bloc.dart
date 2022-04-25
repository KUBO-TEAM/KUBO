import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/data/models/recipe_model.dart';
import 'package:kubo/features/food_planner/domain/entities/ingredient.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_filtered_recipes.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_recipes.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

@injectable
class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final FetchRecipes fetchRecipes;
  final FetchFilteredRecipes fetchFilteredRecipes;

  RecipeBloc({
    required this.fetchRecipes,
    required this.fetchFilteredRecipes,
  }) : super(RecipeInitial()) {
    on<RecipeEvent>((event, emit) async {
      if (event is RecipeModelListFetched) {
        emit(RecipeInProgress());
        final failOrListOfRecipes = await fetchRecipes(NoParams());
        failOrListOfRecipes.fold((failure) {
          emit(RecipeFailure());
        }, (listOfRecipes) {
          emit(RecipeSuccess(recipes: listOfRecipes, cached: listOfRecipes));
        });
      } else if (event is RecipeModelListFilter) {
        String? query = event.query;
        List<Ingredient>? ingredients = event.ingredients;

        emit(RecipeInProgress());

        if (query != null && state is RecipeSuccess) {
          /**
           * Query existing list of arrays
           */
          final recipes = (state as RecipeSuccess).cached;
          var filteredRecipes = recipes.where((recipe) {
            return recipe.name.toLowerCase().contains(query.toLowerCase());
          }).toList();

          emit(RecipeSuccess(recipes: filteredRecipes, cached: recipes));
        } else if (ingredients != null && ingredients.isNotEmpty) {
          /**
           * Fetch and filter a new set of categories
           */

          final failOrListOfFilteredRecipes =
              await fetchFilteredRecipes(ingredients);

          failOrListOfFilteredRecipes.fold(
            (failure) {
              emit(RecipeFailure());
            },
            (listOfRecipes) {
              emit(
                RecipeSuccess(recipes: listOfRecipes, cached: listOfRecipes),
              );
            },
          );
        }
      }
    });
  }
}
