import 'package:equatable/equatable.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';

class PredictedImage extends Equatable {
  final String imageUrl;
  final List<Category> categories;

  const PredictedImage({
    required this.imageUrl,
    required this.categories,
  });

  @override
  List<Object?> get props => [
        imageUrl,
        categories,
      ];
}
