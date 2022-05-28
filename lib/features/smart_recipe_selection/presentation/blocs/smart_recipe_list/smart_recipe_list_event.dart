part of 'smart_recipe_list_bloc.dart';

abstract class SmartRecipeListEvent extends Equatable {
  const SmartRecipeListEvent();

  @override
  List<Object> get props => [];
}

class SmartRecipeListRecipeSchedulesGenerated extends SmartRecipeListEvent {
  final List<Category> categories;

  const SmartRecipeListRecipeSchedulesGenerated({required this.categories});
}
