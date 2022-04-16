import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/captured_page.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/widgets/camera_circle_button.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/widgets/camera_clipper.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/widgets/camera_top_buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {
  static const String id = 'camera_page';
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? controller;

  bool flashSetting = false;
  bool hdrEnabled = true;

  bool showFocusCircle = false;
  double y = 0.0;
  double x = 0.0;

  File? latestCacheImage;

  @override
  void initState() {
    super.initState();
    _getCameras();
    _getFirstCacheFile();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrownPrimary,
      body: SafeArea(
        child: _loadingOrCamera(),
      ),
    );
  }

  Widget _loadingOrCamera() {
    double kScreenWidth = MediaQuery.of(context).size.width;

    if (controller != null) {
      return Stack(
        children: [
          GestureDetector(
            onTapUp: (details) {
              _setFocus(details);
            },
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: CameraPreview(controller!),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: kScreenWidth,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: latestCacheImage != null
                          ? FileImage(latestCacheImage!)
                          : null,
                      backgroundColor: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 20),
                  CameraCircleButton(
                    onPressed: _onTakePictureButtonPressed,
                  ),
                  const SizedBox(width: 20),
                  const SizedBox(width: 30),
                ],
              ),
            ),
          ),
          const CameraClipper(),
          CameraTopButtons(
            setFlashMode: _setFlashMode,
            enabledHDR: _enabledHDR,
          ),
          if (showFocusCircle)
            Positioned(
              top: y - 20,
              left: x - 20,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.yellow, width: 1),
                ),
              ),
            ),
        ],
      );
    }

    return const Center(child: CircularProgressIndicator());
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {}
  }

  Future<void> _getFirstCacheFile() async {
    final tempDirectory = await getTemporaryDirectory();

    final tempDirFiles = tempDirectory.listSync(
      recursive: false,
      followLinks: false,
    );
    // print(tempDirFiles[0].path);
    if (tempDirFiles.isNotEmpty) {
      setState(() {
        latestCacheImage = File(tempDirFiles.last.path);
      });
    }
  }

  Future<void> _getCameras() async {
    List<CameraDescription> cameras;

    cameras = await availableCameras();

    controller = CameraController(
        cameras[0], hdrEnabled ? ResolutionPreset.max : ResolutionPreset.low);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  Future<XFile?> _takePicture() async {
    final CameraController? cameraController = controller;

    if (flashSetting) {
      await controller!.setFlashMode(FlashMode.always);
    } else {
      await controller!.setFlashMode(FlashMode.off);
    }

    if (cameraController == null || !cameraController.value.isInitialized) {
      debugPrint('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  void _onTakePictureButtonPressed() {
    _takePicture().then((XFile? file) {
      if (mounted) {
        if (file != null) {
          Navigator.pushReplacementNamed(
            context,
            CapturedPage.id,
            arguments: CapturedPageArguments(
              imagePath: file.path,
            ),
          );
        }
      }
    });
  }

  Future<void> _setFocus(TapUpDetails details) async {
    if (controller!.value.isInitialized) {
      showFocusCircle = true;
      x = details.localPosition.dx;
      y = details.localPosition.dy;

      double kScreenWidth = MediaQuery.of(context).size.width;
      double cameraHeight = kScreenWidth * controller!.value.aspectRatio;

      double xp = x / kScreenWidth;
      double yp = y / cameraHeight;

      Offset point = Offset(xp, yp);
      // print("point : $point");

      // Manually focus
      await controller!.setFocusPoint(point);

      // Manually set light exposure
      await controller!.setExposurePoint(point);

      setState(() {
        Future.delayed(const Duration(milliseconds: 1000)).whenComplete(() {
          setState(() {
            showFocusCircle = false;
          });
        });
      });
    }
  }

  void _setFlashMode() {
    setState(() {
      flashSetting = !flashSetting;
    });
  }

  void _enabledHDR() {
    setState(() {
      hdrEnabled = !hdrEnabled;
    });
    _getCameras();
  }
}
