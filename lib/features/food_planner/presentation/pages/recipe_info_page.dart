import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/presentation/widgets/icon_button.dart';
import 'package:kubo/features/food_planner/presentation/widgets/image_clipper.dart';
import 'package:kubo/features/food_planner/presentation/widgets/screen_dark_effect.dart';

class RecipeInfoPage extends StatefulWidget {
  static const String id = 'recipe_steps_page';
  const RecipeInfoPage({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  _RecipeInfoPageState createState() => _RecipeInfoPageState();
}

class _RecipeInfoPageState extends State<RecipeInfoPage>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: "recipe-img-${widget.recipe.displayPhoto}",
            child: ImageClipper(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl: widget.recipe.displayPhoto,
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
          Column(children: [
            SizedBox(height: MediaQuery.of(context).viewPadding.top),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CostumeIconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Text(
                      widget.recipe.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'Arvo Bold',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .4 - 190,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                    height: 43,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white54,
                          width: 1,
                        ),
                        color: Colors.black.withOpacity(0.3)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 4,
                      ),
                      child: TabBar(
                        controller: _controller,
                        labelColor: kBrownPrimary,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                        unselectedLabelColor: Colors.white70,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        tabs: const <Widget>[
                          Tab(
                            text: "Ingredients",
                          ),
                          Tab(
                            text: "Steps",
                          ),
                          Tab(
                            text: "Schedule",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 26, right: 26, top: 40.0),
                child: TabBarView(
                  controller: _controller,
                  children: const [
                    Text("Ingredients"),
                    Text("Steps"),
                    Center(
                      child: Icon(
                        Icons.thumb_down,
                        color: Colors.grey,
                        size: 150,
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ],
      ),
    );
  }
}
