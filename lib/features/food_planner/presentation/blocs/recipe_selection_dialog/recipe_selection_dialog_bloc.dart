import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/fetch_categories.dart';

part 'recipe_selection_dialog_event.dart';
part 'recipe_selection_dialog_state.dart';

@injectable
class RecipeSelectionDialogBloc
    extends Bloc<RecipeSelectionDialogEvent, RecipeSelectionDialogState> {
  final FetchCategories fetchCategories;

  RecipeSelectionDialogBloc({required this.fetchCategories})
      : super(RecipeSelectionDialogInitial()) {
    on<RecipeSelectionDialogEvent>((event, emit) async {
      if (event is RecipeSelectionDialogCategoriesFetched) {
        final failureOrCategories = await fetchCategories(NoParams());

        failureOrCategories.fold((failure) {
          emit(
            const RecipeSelectionDialogFailure(
              message: 'Fail to fetch categories...',
            ),
          );
        }, (categories) {
          emit(RecipeSelectionDialogSuccess(categories: categories));
        });
      }
    });
  }
}
