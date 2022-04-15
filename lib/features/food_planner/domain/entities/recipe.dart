import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
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

  final String id;

  final String name;
  final String description;

  final String course;
  final String cuisine;
  final int prepTime;
  final int cookTime;
  final int servings;

  final String reference;
  final String displayPhoto;

  final List<String> categories;
  final List<Map<String, dynamic>> ingredients;
  final List<String> instructions;

  final String createdAt;

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
