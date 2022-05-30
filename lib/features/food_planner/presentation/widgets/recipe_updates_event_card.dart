import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';

class RecipeUpdatesBody extends StatelessWidget {
  const RecipeUpdatesBody({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 16.0,
          bottom: 16.0,
        ),
        constraints: const BoxConstraints(
          minHeight: 150,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                SizedBox(
                  width: 16.0,
                ),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: kGreenPrimary,
                  child: Icon(
                    Icons.newspaper,
                    size: 16.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'New Recipe Added!',
                  style: TextStyle(
                    color: kGreenPrimary,
                    fontFamily: 'Montserrat Medium',
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    recipe.displayPhoto,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                recipe.name,
                style: const TextStyle(
                  color: kBlackPrimary,
                  fontFamily: 'Montserrat Bold',
                  fontSize: 18.0,
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                recipe.description,
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: kBlackPrimary,
                  fontFamily: 'Montserrat',
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
