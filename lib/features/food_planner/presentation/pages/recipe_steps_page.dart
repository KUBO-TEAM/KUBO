import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/temp/recipe.dart';
import 'package:kubo/features/food_planner/presentation/widgets/icon_button.dart';
import 'package:kubo/features/food_planner/presentation/widgets/image_clipper.dart';

class RecipeStepsPage extends StatefulWidget {
  static const String id = 'recipe_steps_page';
  const RecipeStepsPage({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  _RecipeStepsPageState createState() => _RecipeStepsPageState();
}

class _RecipeStepsPageState extends State<RecipeStepsPage>
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
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Hero(
              tag: "recipe-img-${widget.recipe.imageUrl}",
              child: ImageClipper(
                child: Image.network(
                  widget.recipe.imageUrl,
                  fit: BoxFit.cover,
                  color: Colors.black38,
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
            Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 0, top: 5),
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
              const SizedBox(
                height: 100,
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
                      height: 50,
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
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          unselectedLabelStyle:
                              const TextStyle(fontWeight: FontWeight.normal),
                          unselectedLabelColor: Colors.white70,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white),
                          tabs: const <Widget>[
                            Tab(
                              text: "Ingredients",
                            ),
                            Tab(
                              text: "Steps",
                            ),
                            Tab(
                              text: "TBD",
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
                  padding:
                      const EdgeInsets.only(left: 10, right: 25, top: 40.0),
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
      ),
    );
  }
}
