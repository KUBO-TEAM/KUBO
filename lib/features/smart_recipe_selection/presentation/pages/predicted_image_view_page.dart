import 'package:flutter/material.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/widgets/predicted_image_info.dart';

class PredictedImageViewPageArguments {
  final PredictedImage predictedImage;

  PredictedImageViewPageArguments({required this.predictedImage});
}

class PredictedImageViewPage extends StatelessWidget {
  static const String id = 'predicted_image_view_page';

  const PredictedImageViewPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final PredictedImageViewPageArguments arguments;

  @override
  Widget build(BuildContext context) {
    return PredictedImageInfo(
      predictedImage: arguments.predictedImage,
      isNetworkImage: false,
      close: () {
        Navigator.pop(context);
      },
    );
  }
}
