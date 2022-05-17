import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/widgets/kubo_app_bars.dart';
import 'package:kubo/features/food_planner/presentation/widgets/rounded_button.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/blocs/scanned_pictures/scanned_pictures_bloc.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/camera_page.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/smart_recipe_list_page.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/widgets/scanned_pictures_list_tile.dart';
import 'package:skeletons/skeletons.dart';

class ScannedPicturesListPageArguments {
  final String imagePath;

  ScannedPicturesListPageArguments({required this.imagePath});
}

class ScannedPicturesListPage extends StatefulWidget {
  static const String id = 'scanned_picture_list_page';

  const ScannedPicturesListPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final ScannedPicturesListPageArguments arguments;

  @override
  State<ScannedPicturesListPage> createState() =>
      _ScannedPicturesListPageState();
}

class _ScannedPicturesListPageState extends State<ScannedPicturesListPage> {
  List<String> selectedPictures = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kBrownPrimary,
        child: const Icon(Icons.delete),
      ),
      appBar: KuboAppBar(
        'Scanned Pictures',
        onBackButtonPressed: () =>
            Navigator.of(context).pushReplacementNamed(CameraPage.id),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedButton(
                  icon: const Icon(
                    Icons.camera,
                  ),
                  title: const Text(
                    'Scan again',
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed(CameraPage.id),
                ),
                const SizedBox(
                  width: 5,
                ),
                RoundedButton(
                  icon: const Icon(Icons.schedule),
                  title: const Text(
                    'Generate schedule',
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(SmartRecipeListPage.id),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Expanded(
            child: BlocBuilder<ScannedPicturesBloc, ScannedPicturesState>(
              builder: (context, state) {
                if (state is ScannedPicturesInProgress) {
                  return GridView.builder(
                    itemCount: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: SkeletonItem(child: SkeletonAvatar()),
                      );
                    },
                  );
                } else if (state is ScannedPicturesSuccess) {
                  final pictures = state.pictures;

                  return GridView.builder(
                    itemCount: pictures.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return ScannedPicturesListTile(
                        picture: pictures[index],
                        onChange: (String picture) {
                          selectedPictures.add(picture);
                        },
                      );
                    },
                  );
                }

                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
