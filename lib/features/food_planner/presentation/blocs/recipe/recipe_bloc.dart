import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/category.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_cache_recipe.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_cached_recipes.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_filtered_recipes.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_recipes.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

// TODO: Seperate caching recipes and remote recipes bloc
@injectable
class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final FetchRecipes fetchRecipes;
  final FetchFilteredRecipes fetchFilteredRecipes;
  final CreateCacheRecipe createCacheRecipe;
  final FetchCachedRecipes fetchCachedRecipes;

  RecipeBloc({
    required this.fetchRecipes,
    required this.fetchFilteredRecipes,
    required this.createCacheRecipe,
    required this.fetchCachedRecipes,
  }) : super(RecipeInitial()) {
    on<RecipeEvent>((event, emit) async {
      if (event is RecipeModelListFetched) {
        if (state is RecipeInitial) {
          emit(RecipeInProgress());
        }

        final failOrCachedRecipes = await fetchCachedRecipes(NoParams());
        final failOrRecipes = await fetchRecipes(NoParams());

        await _eitherLoadedCachedOrErroState(emit, failOrCachedRecipes);
        await _eitherLoadedOrErrorState(emit, failOrRecipes);
      } else if (event is RecipeModelListFilter) {
        String? query = event.query;
        List<Category>? categories = event.categories;

        if (query != null && state is RecipeSuccess) {
          /**
           * Query existing list of arrays
           */
          final recipes = (state as RecipeSuccess).cached;

          if (state is RecipeInitial) {
            emit(RecipeInProgress());
          }

          var filteredRecipes = recipes.where((recipe) {
            return recipe.name.toLowerCase().contains(query.toLowerCase());
          }).toList();

          emit(RecipeSuccess(recipes: filteredRecipes, cached: recipes));
        } else if (categories != null) {
          if (state is RecipeInitial) {
            emit(RecipeInProgress());
          }

          if (categories.isEmpty) {
            final failOrCachedRecipes = await fetchCachedRecipes(NoParams());
            final failOrRecipes = await fetchRecipes(NoParams());

            await _eitherLoadedCachedOrErroState(emit, failOrCachedRecipes);
            await _eitherLoadedOrErrorState(emit, failOrRecipes);
          } else {
            final failOrListOfFilteredRecipes =
                await fetchFilteredRecipes(categories);

            await _eitherLoadedOrErrorState(emit, failOrListOfFilteredRecipes);
          }
        }
      }
    });
  }

  Future<void> _eitherLoadedCachedOrErroState(
    Emitter<RecipeState> emit,
    Either<Failure, List<Recipe>> failOrCachedRecipes,
  ) async {
    await failOrCachedRecipes.fold((failure) async {}, (listOfRecipes) async {
      if (listOfRecipes.isNotEmpty) {
        emit(
          RecipeSuccess(
            recipes: listOfRecipes,
            cached: listOfRecipes,
          ),
        );
      }
    });
  }

  Future<void> _eitherLoadedOrErrorState(
    Emitter<RecipeState> emit,
    Either<Failure, List<Recipe>> failOrRecipes,
  ) async {
    failOrRecipes.fold(
      (failure) {
        // Cannot update the cached data something went wrong in the server
      },
      (listOfRecipes) async {
        emit(
          RecipeSuccess(
            recipes: listOfRecipes,
            cached: listOfRecipes,
          ),
        );

        _createCachedRecipes(listOfRecipes);
      },
    );
  }

  Future<void> _createCachedRecipes(List<Recipe> listOfRecipes) async {
    await createCacheRecipe(
      CreateCacheRecipeParams(recipes: listOfRecipes),
    );
  }
}
