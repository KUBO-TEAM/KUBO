import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/features/food_planner/presentation/widgets/message_dialog.dart';
import 'package:kubo/features/food_planner/presentation/widgets/rounded_button.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/blocs/captured_page/save_scanned_ingredients_bloc.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/blocs/predict_image/predict_image_bloc.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/camera_page.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/scanned_pictures_list_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/widgets/detected_categories_dialog.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/widgets/predicted_image_info.dart';
import 'package:permission_handler/permission_handler.dart';

class CapturedPageArguments {
  final String imagePath;

  CapturedPageArguments({required this.imagePath});
}

class CapturedPage extends StatefulWidget {
  static const String id = 'captured_page';
  const CapturedPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final CapturedPageArguments arguments;

  @override
  State<CapturedPage> createState() => _CapturedPageState();
}

class _CapturedPageState extends State<CapturedPage> {
  PredictedImage? predictedImage;

  Future<String?> downloadImage(String imageUrl) async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(
        imageUrl,
        destination: AndroidDestinationType.directoryPictures
          ..inExternalFilesDir(),
      );

      if (imageId == null) {
        return null;
      }

      // Below is a method of obtaining saved image information.
      // var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      // var size = await ImageDownloader.findByteSize(imageId);
      // var mimeType = await ImageDownloader.findMimeType(imageId);

      return path;
    } on PlatformException catch (error) {
      debugPrint(error.message);
      return null;
    }
  }

  Future<void> saveImageToExternalStorage(String imagePath) async {
    var externalPath = await ExternalPath.getExternalStoragePublicDirectory(
      ExternalPath.DIRECTORY_PICTURES,
    );

    var file = XFile(imagePath);

    var directory = Directory('$externalPath/kubo');

    if (directory.existsSync() == false) {
      directory.createSync();
    }

    String externalFilePath = '$externalPath/kubo/${file.name}';

    await file.saveTo(externalFilePath);
  }

  Future<void> saveScannedIngredients() async {
    //TODO: Add dialog if permission is not granted
    if (await Permission.storage.request().isGranted) {
      EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
      final predictedImageFinal = predictedImage;

      if (predictedImageFinal == null) {
        return;
      }

      String? path = await downloadImage(predictedImageFinal.imageUrl);

      if (path == null) {
        return;
      }

      await saveImageToExternalStorage(path);

      EasyLoading.dismiss();

      /** Image Path Edits */
      final predictedImageCopy = PredictedImage.clone(predictedImageFinal);

      predictedImageCopy.imageUrl = path;

      for (Category category in predictedImageCopy.categories) {
        category.imageUrl = path;
      }

      /** Save Scanned Predicted Image */
      BlocProvider.of<SaveScannedIngredientsBloc>(context).add(
        SaveScannedIngredientsCreatedPredictedImage(
          predictedImage: predictedImageCopy,
        ),
      );
      Navigator.of(context).pushNamedAndRemoveUntil(
        ScannedPicturesListPage.id,
        (route) => route.isFirst,
      );
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
            predictedImage = state.predictedImage;
            if (state.predictedImage.categories.isNotEmpty) {
              showDialog(
                context: context,
                builder: (_) => DetectedCategoriesDialog(
                  categories: state.predictedImage.categories,
                ),
              );
            }
          }
          if (state is PredictImageFailure) {
            showDialog(
              context: context,
              builder: (_) => const MessageDialog(
                title: 'Sorry for the inconvenience ',
                message:
                    'It seems that you encounter a server error, the server might go on maintenance or your internet connection is slow, please contact us on our website, https://kuboph.dev',
              ),
            );
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

            bool isCategoriesNotEmpty =
                state.predictedImage.categories.isNotEmpty;

            return PredictedImageInfo(
              predictedImage: state.predictedImage,
              buttonCenterBottom: RoundedButton(
                icon: isCategoriesNotEmpty ? const Icon(Icons.save) : null,
                title: Text(
                  isCategoriesNotEmpty
                      ? 'Save as scanned ingredients'
                      : 'No ingredients scanned, Please try again.',
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                onPressed: () {
                  if (isCategoriesNotEmpty) {
                    saveScannedIngredients();
                  } else {
                    Navigator.pushReplacementNamed(
                      context,
                      CameraPage.id,
                    );
                  }
                },
              ),
              isNetworkImage: true,
              close: () {
                Navigator.pushReplacementNamed(
                  context,
                  CameraPage.id,
                );
              },
            );
          }

          return Stack(
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
                    color: Colors.black.withOpacity(0.4),
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
