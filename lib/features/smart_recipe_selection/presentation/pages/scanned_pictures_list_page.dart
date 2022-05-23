import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/widgets/kubo_app_bars.dart';
import 'package:kubo/features/food_planner/presentation/widgets/rounded_button.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/blocs/scanned_pictures_list/scanned_pictures_list_bloc.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/camera_page.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/smart_recipe_list_page.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/widgets/scanned_pictures_list_tile.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletons/skeletons.dart';

//TODO: Add delete ingredients if expired
class ScannedPicturesListPage extends StatefulWidget {
  static const String id = 'scanned_picture_list_page';

  const ScannedPicturesListPage({Key? key}) : super(key: key);

  @override
  State<ScannedPicturesListPage> createState() =>
      _ScannedPicturesListPageState();
}

class _ScannedPicturesListPageState extends State<ScannedPicturesListPage> {
  List<String> selectedPictures = [];

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ScannedPicturesListBloc>(context).add(
      ScannedPicturesListFetched(),
    );
  }

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
        onBackButtonPressed: () => Navigator.of(context).pop(),
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
                  onPressed: () async {
                    if (await Permission.camera.request().isGranted &&
                        await Permission.storage.request().isGranted) {
                      Navigator.pushNamed(context, CameraPage.id);
                    }
                  },
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
            child:
                BlocBuilder<ScannedPicturesListBloc, ScannedPicturesListState>(
              builder: (context, state) {
                if (state is ScannedPicturesListInProgress) {
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
                } else if (state is ScannedPicturesListSuccess) {
                  final predictedImages = state.predictedImages;

                  return GridView.builder(
                    itemCount: predictedImages.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return ScannedPicturesListTile(
                        predictedImage: predictedImages[index],
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
