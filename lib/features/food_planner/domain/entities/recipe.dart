import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:kubo/features/food_planner/domain/entities/ingredient.dart';

part 'recipe.g.dart';

@HiveType(typeId: 2)
class Recipe extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String course;

  @HiveField(4)
  final String cuisine;

  @HiveField(5)
  final int prepTime;

  @HiveField(6)
  final int cookTime;

  @HiveField(7)
  final int servings;

  @HiveField(8)
  final String reference;

  @HiveField(9)
  final String displayPhoto;

  @HiveField(10)
  final List<String> categories;

  @HiveField(11)
  final List<Ingredient> ingredients;

  @HiveField(12)
  final List<String> instructions;

  @HiveField(13)
  final String createdAt;

  const Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.course,
    required this.cuisine,
    required this.prepTime,
    required this.cookTime,
    required this.servings,
    required this.reference,
    required this.displayPhoto,
    required this.categories,
    required this.ingredients,
    required this.instructions,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        course,
        cuisine,
        prepTime,
        cookTime,
        servings,
        reference,
        displayPhoto,
        categories,
        ingredients,
        instructions,
        createdAt
      ];
}
