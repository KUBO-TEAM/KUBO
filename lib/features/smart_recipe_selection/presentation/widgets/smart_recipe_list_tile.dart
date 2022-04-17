import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/data/models/recipe_model.dart';
import 'package:kubo/features/food_planner/presentation/widgets/screen_dark_effect.dart';
import 'package:skeletons/skeletons.dart';

class SmartRecipeListTile extends StatelessWidget {
  const SmartRecipeListTile({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 10.0,
        bottom: 30.0,
      ),
      width: 350,
      child: Stack(
        children: [
          Positioned(
            height: 260,
            width: 350,
            child: Card(
              elevation: 3,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: Image.network(
                recipe.displayPhoto,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(kBrownPrimary),
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
          Positioned(
            width: 300,
            height: 140,
            top: 200,
            left: 25,
            child: Card(
              elevation: 10,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 30.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      recipe.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          width: 180,
                          child: Text(
                            recipe.description,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 110, 110, 110),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${recipe.cookTime} MIN',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          color: Colors.black,
                          width: 2,
                          height: 16,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${recipe.prepTime} MIN',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SmartRecipeListSkeleton extends StatelessWidget {
  const SmartRecipeListSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 10.0,
        bottom: 30.0,
      ),
      width: 350,
      child: const Card(
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        child: SkeletonItem(
          child: SkeletonAvatar(),
        ),
      ),
    );
  }
}
