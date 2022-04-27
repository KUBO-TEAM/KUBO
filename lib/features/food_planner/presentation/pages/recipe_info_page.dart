import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_info_page_background.dart';

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 20),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title: Text(
          widget.recipe.name,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Pushster',
            fontSize: 30.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            minHeight: 270,
          ),
          child: Stack(
            children: [
              RecipeInfoPageBackground(recipe: widget.recipe),
              Container(
                // color: Colors.red,
                width: double.infinity,
                constraints: const BoxConstraints(
                  minHeight: 270,
                ),
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 155,
                ),
                child: Column(
                  children: [
                    ClipRRect(
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
                                fontSize: 13,
                              ),
                              unselectedLabelStyle: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 11,
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
                    TabBarView(
                      controller: _controller,
                      children: [
                        Container(
                          color: Colors.red,
                          child: const Text('test'),
                        ),
                        const Text("Steps"),
                        const Center(
                          child: Icon(
                            Icons.thumb_down,
                            color: Colors.grey,
                            size: 150,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
