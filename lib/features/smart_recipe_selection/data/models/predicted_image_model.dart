import '../../domain/entities/predicted_image.dart';

class PredictedImageModel extends PredictedImage {
  const PredictedImageModel({
    required String imageUrl,
    required List<String> ingredients,
  }) : super(
          imageUrl: imageUrl,
          ingredients: ingredients,
        );

  factory PredictedImageModel.fromJson(Map<String, dynamic> json) {
    return PredictedImageModel(
      imageUrl: json['imageUrl'],
      ingredients: List<String>.from(json['ingredients']),
    );
  }
}
