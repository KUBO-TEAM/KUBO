import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/presentation/widgets/screen_dark_effect.dart';
import 'package:skeletons/skeletons.dart';

class RecipeListTile extends StatelessWidget {
  const RecipeListTile({
    Key? key,
    required this.recipe,
    required this.onPressed,
  }) : super(key: key);

  final Recipe recipe;
  final Function(Recipe) onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed(recipe);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        child: Card(
          elevation: 7,
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Stack(
            children: [
              Hero(
                tag: "recipe-img-${recipe.displayPhoto}",
                child: CachedNetworkImage(
                  imageUrl: recipe.displayPhoto,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  progressIndicatorBuilder: (context, url, downloadProgress) {
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
              Container(
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  recipe.name,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat Bold',
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeListTileSkeleton extends StatelessWidget {
  const RecipeListTileSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: SkeletonItem(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            child: SkeletonAvatar(),
          ),
          SkeletonParagraph(
            style: SkeletonParagraphStyle(
              lines: 3,
              spacing: 6,
              lineStyle: SkeletonLineStyle(
                randomLength: true,
                height: 10,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
