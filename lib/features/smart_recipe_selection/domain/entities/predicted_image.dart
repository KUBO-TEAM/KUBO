import 'package:equatable/equatable.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';

//TODO: make it hive!

class PredictedImage extends Equatable {
  final String imageUrl;
  final DateTime predictedAt;
  final List<Category> categories;

  const PredictedImage({
    required this.imageUrl,
    required this.categories,
    required this.predictedAt,
  });

  @override
  List<Object?> get props => [
        imageUrl,
        categories,
      ];
}
