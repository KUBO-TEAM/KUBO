import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/data/models/recipe_model.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipe_steps_page.dart';
import 'package:skeletons/skeletons.dart';

class RecipeListTile extends StatelessWidget {
  const RecipeListTile({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RecipeStepsPage.id,
        arguments: recipe,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        child: Card(
          elevation: 7,
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Hero(
                  tag: "recipe-img-${recipe.displayPhoto}",
                  child: Image.network(
                    recipe.displayPhoto,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            kBrownPrimary,
                          ),
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        recipe.name,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      recipe.description,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ],
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
      padding: const EdgeInsets.all(10.0),
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
