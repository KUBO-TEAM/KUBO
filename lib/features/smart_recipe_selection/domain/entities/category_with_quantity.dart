import 'package:equatable/equatable.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';

class CategoryWithQuantity extends Equatable {
  final int quantity;
  final Category category;

  const CategoryWithQuantity({
    required this.quantity,
    required this.category,
  });

  @override
  List<Object?> get props => [
        quantity,
        category,
      ];
}
