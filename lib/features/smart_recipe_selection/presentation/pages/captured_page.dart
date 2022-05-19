import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/widgets/rounded_button.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/blocs/predict_image/predict_image_bloc.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/blocs/scanned_pictures/scanned_pictures_bloc.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/camera_page.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/scanned_pictures_list_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/widgets/detected_categories_dialog.dart';

class CapturedPageArguments {
  final String imagePath;

  CapturedPageArguments({required this.imagePath});
}

class CapturedPage extends StatefulWidget {
  static const String id = 'captured_page';
  const CapturedPage({Key? key, required this.arguments}) : super(key: key);

  final CapturedPageArguments arguments;

  @override
  State<CapturedPage> createState() => _CapturedPageState();
}

class _CapturedPageState extends State<CapturedPage> {
  PredictedImage? predictedImage;

  void saveScannedIngredients() async {
    EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    final predictedImageFinal = predictedImage;

    if (predictedImageFinal == null) {
      return;
    }

    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(
        predictedImageFinal.imageUrl,
        destination: AndroidDestinationType.directoryPictures
          ..inExternalFilesDir(),
      );

      if (imageId == null) {
        return;
      }

      // Below is a method of obtaining saved image information.
      // var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      // var size = await ImageDownloader.findByteSize(imageId);
      // var mimeType = await ImageDownloader.findMimeType(imageId);

      var externalPath = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_PICTURES,
      );

      if (path == null) {
        return;
      }

      var file = XFile(path);

      var directory = Directory('$externalPath/kubo');

      if (directory.existsSync() == false) {
        directory.createSync();
      }

      await file.saveTo('$externalPath/kubo/${file.name}');

      String externalFilePath = '$externalPath/kubo/${file.name}';

      EasyLoading.dismiss();

      BlocProvider.of<ScannedPicturesBloc>(context).add(
        ScannedPicturesSaved(imagePath: externalFilePath),
      );
      Navigator.pushReplacementNamed(
        context,
        ScannedPicturesListPage.id,
        arguments: ScannedPicturesListPageArguments(
          imagePath: externalFilePath,
        ),
      );
    } on PlatformException catch (error) {
      debugPrint(error.message);
    }
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<PredictImageBloc>(context).add(
      PredictImagePredicted(imagePath: widget.arguments.imagePath),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<PredictImageBloc, PredictImageState>(
        listener: (context, state) {
          if (state is PredictImageSuccess) {
            if (state.predictedImage.categories.isNotEmpty) {
              showDialog(
                context: context,
                builder: (_) => DetectedCategoriesDialog(
                  categories: state.predictedImage.categories,
                ),
              );
            }
          }
        },
        builder: (context, state) {
          if (state is PredictImageInProgress) {
            EasyLoading.show(
              status: 'loading...',
              maskType: EasyLoadingMaskType.black,
            );
          }
          if (state is PredictImageFailure) {
            EasyLoading.dismiss();
          }
          if (state is PredictImageSuccess) {
            EasyLoading.dismiss();
            predictedImage = state.predictedImage;
          }

          return state is PredictImageSuccess
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      predictedImage!.imageUrl,
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                    ),
                    ClipRRect(
                      // Clip it cleanly.
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.grey.withOpacity(0.1),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).viewPadding.top + 55,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 30,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.predictedImage.categories.length,
                              padding: const EdgeInsets.only(
                                left: 30.0,
                              ),
                              itemBuilder: (
                                BuildContext context,
                                int index,
                              ) {
                                return Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: kBboxColorClass[state
                                          .predictedImage
                                          .categories[index]
                                          .name],
                                      radius: 6.0,
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      state.predictedImage.categories[index]
                                          .name,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Montserrat Medium',
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: Image.network(
                              predictedImage!.imageUrl,
                              alignment: Alignment.center,
                              loadingBuilder: (
                                BuildContext context,
                                Widget child,
                                ImageChunkEvent? loadingProgress,
                              ) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: MediaQuery.of(context).viewPadding.top + 5,
                      child: Row(
                        children: [
                          if (state.predictedImage.categories.isNotEmpty)
                            RoundedButton(
                              icon: const Icon(Icons.restaurant),
                              title: const Text(
                                'Show accuracy result list',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => DetectedCategoriesDialog(
                                    categories: state.predictedImage.categories,
                                  ),
                                );
                              },
                            ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, CameraPage.id);
                            },
                            child: const Icon(Icons.close, color: Colors.white),
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(2.0),
                              primary: kBrownPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    state.predictedImage.categories.isNotEmpty
                        ? Positioned(
                            bottom: 16,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: RoundedButton(
                                icon: const Icon(Icons.save),
                                title: const Text(
                                  'Save as scanned ingredients',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                onPressed: saveScannedIngredients,
                              ),
                            ),
                          )
                        : Positioned(
                            bottom: 16,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: RoundedButton(
                                title: const Text(
                                  'No ingredients scanned, Please try again.',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    CameraPage.id,
                                  );
                                },
                              ),
                            ),
                          ),
                  ],
                )
              : Stack(
                  children: [
                    Image.file(
                      File(widget.arguments.imagePath),
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                    ),
                    ClipRRect(
                      // Clip it cleanly.
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.grey.withOpacity(0.1),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    Image.file(
                      File(widget.arguments.imagePath),
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    ),
                  ],
                );
        },
      ),
    );
  }
}
