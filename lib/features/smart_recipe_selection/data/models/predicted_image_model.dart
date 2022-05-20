import 'package:kubo/features/smart_recipe_selection/data/models/category_model.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';

import '../../domain/entities/predicted_image.dart';

class PredictedImageModel extends PredictedImage {
  const PredictedImageModel({
    required String imageUrl,
    required DateTime predictedAt,
    required List<Category> categories,
  }) : super(
          imageUrl: imageUrl,
          predictedAt: predictedAt,
          categories: categories,
        );

  factory PredictedImageModel.fromJson(Map<String, dynamic> raw) {
    Iterable categories = raw['categories'];
    return PredictedImageModel(
      imageUrl: raw['imageUrl'],
      predictedAt: DateTime.parse(raw['predictedAt']),
      categories: List<Category>.from(
        categories.map(
          (category) => CategoryModel.fromJson(category),
        ),
      ),
    );
  }
}
