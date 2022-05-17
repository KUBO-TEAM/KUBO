import 'dart:io';

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
  PredictedImage? resultUrl;

  void saveScannedIngredients() async {
    EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    final url = resultUrl;

    if (url == null) {
      return;
    }

    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(
        url.imageUrl,
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
      print(error);
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
      body: Stack(children: [
        BlocBuilder<PredictImageBloc, PredictImageState>(
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
              resultUrl = state.predictedImage;

              return Image.network(
                resultUrl!.imageUrl,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              );
            }
            return Image.file(
              File(widget.arguments.imagePath),
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            );
          },
        ),
        Positioned(
          right: 0,
          top: MediaQuery.of(context).viewPadding.top,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, CameraPage.id);
            },
            child: const Icon(Icons.close, color: Colors.white),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(2.0),
              primary: kBrownPrimary,
            ),
          ),
        ),
        Positioned(
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
        ),
      ]),
    );
  }
}
