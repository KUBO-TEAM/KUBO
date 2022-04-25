import 'package:equatable/equatable.dart';

class PredictedImage extends Equatable {
  final String imageUrl;
  final List<String> ingredients;

  const PredictedImage({required this.imageUrl, required this.ingredients});

  @override
  List<Object?> get props => [imageUrl, ingredients];
}
