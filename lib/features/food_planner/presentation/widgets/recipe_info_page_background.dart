import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/presentation/widgets/image_clipper.dart';
import 'package:kubo/features/food_planner/presentation/widgets/screen_dark_effect.dart';

class RecipeInfoPageBackground extends StatelessWidget {
  const RecipeInfoPageBackground({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: Stack(
        children: <Widget>[
          Hero(
            tag: "recipe-img-${recipe.displayPhoto}",
            child: ImageClipper(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl: recipe.displayPhoto,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) {
                        // if (downloadProgress == null) return Container();
                        return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              kBrownPrimary,
                            ),
                            value: downloadProgress.progress,
                          ),
                        );
                      },
                    ),
                  ),
                  const ScreenDarkEffect(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
