import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required String name,
    required double accuracy,
    required DateTime predictedAt,
    required String imageUrl,
  }) : super(
          name: name,
          accuracy: accuracy,
          predictedAt: predictedAt,
          imageUrl: imageUrl,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'],
      accuracy: (json['accuracy'] as double),
      predictedAt: DateTime.parse(json['predictedAt']),
      imageUrl: json['imageUrl'],
    );
  }
}
