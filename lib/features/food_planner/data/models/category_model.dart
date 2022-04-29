import 'package:kubo/features/food_planner/domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required String name,
    required int quantity,
    required DateTime dateCreated,
  }) : super(
          name: name,
          quantity: quantity,
          dateCreated: dateCreated,
        );
}
