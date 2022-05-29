import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/constants/string_constants.dart';
import 'package:kubo/features/food_planner/presentation/blocs/create_recipe_schedule_dialog/create_recipe_schedule_dialog_bloc.dart';
import 'package:kubo/features/food_planner/presentation/widgets/ingredient_expired_dialog.dart';
import 'package:kubo/features/food_planner/presentation/widgets/kubo_app_bars.dart';
import 'package:kubo/features/food_planner/presentation/widgets/message_dialog.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_selection_dialog.dart';
import 'package:kubo/features/food_planner/presentation/widgets/rounded_button.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/blocs/scanned_pictures_list/scanned_pictures_list_bloc.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/camera_page.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/smart_recipe_list_page.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/widgets/scanned_pictures_list_tile.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletons/skeletons.dart';

class ScannedPicturesListPage extends StatefulWidget {
  static const String id = 'scanned_picture_list_page';

  const ScannedPicturesListPage({Key? key}) : super(key: key);

  @override
  State<ScannedPicturesListPage> createState() =>
      _ScannedPicturesListPageState();
}

class _ScannedPicturesListPageState extends State<ScannedPicturesListPage> {
  List<PredictedImage> selectedPredictedImages = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CreateRecipeScheduleDialogBloc>(context).add(
      CreateRecipeScheduleDialogInitializeState(),
    );
    BlocProvider.of<ScannedPicturesListBloc>(context).add(
      ScannedPicturesListFetched(),
    );
  }

  void predictedImageSelected(PredictedImage selectedPredictedImage) {
    bool isSelectedImageExist =
        selectedPredictedImages.contains(selectedPredictedImage);

    if (isSelectedImageExist) {
      selectedPredictedImages.remove(selectedPredictedImage);
    } else {
      selectedPredictedImages.add(selectedPredictedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedPredictedImages.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: const Color.fromARGB(255, 141, 87, 0),
                content: Row(
                  children: const [
                    Icon(
                      Icons.priority_high,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'No selected predicted images.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
            return;
          }
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Accept ?'),
              content: const Text(
                'Are you sure you want to delete this predicted images?',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    BlocProvider.of<ScannedPicturesListBloc>(context).add(
                      ScannedPicturesListPredictedImagesDeleted(
                        predictedImages: selectedPredictedImages,
                      ),
                    );

                    selectedPredictedImages = [];
                    Navigator.pop(context);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No'),
                ),
              ],
            ),
          );
        },
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
                    } else {
                      showDialog(
                        context: context,
                        builder: (_) => const MessageDialog(
                          title: 'Permission is required!',
                          message: kPermissionDenniedDialogMessage,
                        ),
                      );
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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return RecipeSelectionDialog(
                          actionButton: (selectedCategories) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                RoundedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      SmartRecipeListPage.id,
                                      arguments: SmartRecipeListPageArguments(
                                        categories: selectedCategories,
                                      ),
                                    );
                                  },
                                  title: const Text(
                                    'Generate recipes schedule',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat Medium',
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Expanded(
            child:
                BlocConsumer<ScannedPicturesListBloc, ScannedPicturesListState>(
              listener: (context, state) {
                if (state is ScannedPicturesListSuccess) {
                  final thereIsAnExpiredPredictedImage =
                      state.thereIsAnExpiredPredictedImage;

                  if (thereIsAnExpiredPredictedImage != null &&
                      thereIsAnExpiredPredictedImage == true) {
                    showDialog(
                      context: context,
                      builder: (_) => const IngredientExpiredDialog(),
                    );
                  }
                }
              },
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
                        key: ValueKey(predictedImages.length + index),
                        predictedImage: predictedImages[index],
                        onChange: predictedImageSelected,
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
