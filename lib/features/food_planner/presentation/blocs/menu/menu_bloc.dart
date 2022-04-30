import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_recipe_schedules.dart';

part 'menu_event.dart';
part 'menu_state.dart';

@injectable
class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final FetchRecipeSchedules fetchRecipeSchedules;

  MenuBloc({
    required this.fetchRecipeSchedules,
  }) : super(MenuInitial()) {
    on<MenuEvent>((event, emit) async {
      if (event is MenuRecipeScheduleFetched) {
        emit(MenuRecipeScheduleFetchInProgress());

        final failureOrRecipeFetched = await fetchRecipeSchedules(NoParams());

        failureOrRecipeFetched.fold((failure) {
          emit(
            const MenuRecipeScheduleFetchFailure(
              message: 'Recipe fetched fails',
            ),
          );
        }, (recipeSchedules) {
          emit(
            MenuRecipeScheduleFetchSuccess(recipeSchedules: recipeSchedules),
          );
        });
      }
    });
  }
}
