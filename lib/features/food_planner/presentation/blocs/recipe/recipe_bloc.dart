import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/data/models/recipe_model.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_recipes.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

@injectable
class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final FetchRecipes fetchRecipes;

  RecipeBloc({required this.fetchRecipes}) : super(RecipeInitial()) {
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
        if (state is RecipeSuccess) {
          final recipes = (state as RecipeSuccess).cached;

          emit(RecipeInProgress());

          var filteredRecipes = recipes.where((recipe) {
            return recipe.name
                .toLowerCase()
                .contains(event.query.toLowerCase());
          }).toList();

          emit(RecipeSuccess(recipes: filteredRecipes, cached: recipes));
        }
      }
    });
  }
}
