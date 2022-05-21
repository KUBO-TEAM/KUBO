import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';
import 'package:hive/hive.dart';

part 'predicted_image.g.dart';

const kPredictedImageBoxKey = 'Predicted Image Box Key';

@HiveType(typeId: 6)
class PredictedImage extends HiveObject {
  @HiveField(1)
  String imageUrl;

  @HiveField(22)
  final DateTime predictedAt;

  @HiveField(3)
  final List<Category> categories;

  PredictedImage({
    required this.imageUrl,
    required this.categories,
    required this.predictedAt,
  });
}
