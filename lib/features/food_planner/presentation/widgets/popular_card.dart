import 'package:flutter/material.dart';
import 'package:kubo/core/constants/text_styles_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';

class PopularCard extends StatelessWidget {
  const PopularCard({
    Key? key,
    required this.recipe,
    required this.onPressed,
  }) : super(key: key);

  final Recipe recipe;
  final Function(Recipe) onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed(recipe);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(13.0)),
              ),
              child: Image.network(
                recipe.displayPhoto,
                fit: BoxFit.cover,
                height: 80.0,
                width: 75.0,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: kSubTitleTextStyle.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    recipe.description,
                    style: kCaptionTextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
