part of 'recipe_updates_bloc.dart';

abstract class RecipeUpdatesEvent extends Equatable {
  const RecipeUpdatesEvent();

  @override
  List<Object> get props => [];
}

class RecipeUpdatesLatestRecipeFetched extends RecipeUpdatesEvent {}
