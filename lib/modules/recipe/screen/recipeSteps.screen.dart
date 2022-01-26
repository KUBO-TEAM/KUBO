import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/modules/meal_plan/models/recipe.dart';
import 'package:kubo/widgets/buttons/icon.button.dart';
import 'package:kubo/widgets/clippers/image.clipper.dart';

class RecipeSteps extends StatefulWidget {
  static const String id = 'recipe_steps_screen';
  const RecipeSteps({Key? key}) : super(key: key);

  @override
  _RecipeStepsState createState() => _RecipeStepsState();
}

class _RecipeStepsState extends State<RecipeSteps>
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
    final args = ModalRoute.of(context)!.settings.arguments as Recipe;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Hero(
              tag: "recipe-img-${args.imageUrl}",
              child: ImageClipper(
                child: Image.network(
                  args.imageUrl,
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
                        args.name,
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
                        borderRadius:BorderRadius.circular(25),
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
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          unselectedLabelStyle:
                              TextStyle(fontWeight: FontWeight.normal),
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
                    children: <Widget>[
                      Text("Ingredients"),
                      Text("Steps"),
                      Container(child: const Center(child: Icon(Icons.thumb_down,color: Colors.grey,size: 150,),),)
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
