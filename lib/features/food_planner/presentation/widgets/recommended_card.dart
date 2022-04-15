import 'package:flutter/material.dart';
import 'package:kubo/core/constants/text_styles_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';

class RecommendedCard extends StatelessWidget {
  const RecommendedCard({
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
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                height: 150.0,
                width: 180.0,
              ),
            ),
            SizedBox(
              width: 180.0,
              child: Text(
                recipe.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: kCaptionTextStyle.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
