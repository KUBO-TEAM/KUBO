import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:kubo/modules/camera/screens/captured.screen.dart';
import 'package:kubo/widgets/buttons/icon.button.dart';
import 'package:kubo/widgets/clippers/camera.clipper.dart';
import 'dart:async';
// import 'package:kubo/widgets/buttons/icon.button.dart';

class CameraState extends StatefulWidget {
  const CameraState({Key? key}) : super(key: key);

  @override
  State<CameraState> createState() => _CameraState();
}

class _CameraState extends State<CameraState> {
  CameraController? controller;

  bool flashSetting = false;
  bool hdrEnabled = true;

  bool showFocusCircle = false;
  double y = 0.0;
  double x = 0.0;

  @override
  void initState() {
    super.initState();
    _getCameras();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
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
          // final Directory dir = await getApplicationDocumentsDirectory();
          // final File fileToCopy = File(file.path);
          // final File newImage =
          //     await fileToCopy.copy('/storage/emulated/0/Download/image1.jpg');

          Navigator.pushNamed(
            context,
            CapturedScreen.id,
            arguments: CapturedScreenArguments(
              imagePath: file.path,
            ),
          );

          debugPrint('Picture saved to ${file.path}');
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

  @override
  Widget build(BuildContext context) {
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
            bottom: 20,
            left: (kScreenWidth / 2) - 35,
            child: CameraCircleButton(
              onPressed: _onTakePictureButtonPressed,
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
                      // borderRadius: ,
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.yellow, width: 1)),
                )),
        ],
      );
    }
    return Container();
  }
}

class CameraTopButtons extends StatelessWidget {
  const CameraTopButtons({
    Key? key,
    required this.setFlashMode,
    required this.enabledHDR,
  }) : super(key: key);

  final Function() setFlashMode;
  final Function() enabledHDR;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          CostumeIconButton(
            onPressed: setFlashMode,
            icon: const Icon(
              Icons.flash_on,
              color: Colors.amber,
              size: 24.0,
            ),
            pressedIcon: const Icon(
              Icons.flash_off,
              color: Colors.white,
              size: 24.0,
            ),
          ),
          CostumeIconButton(
            onPressed: enabledHDR,
            icon: const Icon(
              Icons.hdr_off,
              color: Colors.white,
              size: 50.0,
            ),
            pressedIcon: const Icon(
              Icons.hdr_on,
              color: Colors.amber,
              size: 50.0,
            ),
          ),
        ],
      ),
    );
  }
}

class CameraCircleButton extends StatelessWidget {
  const CameraCircleButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const CircleAvatar(
        backgroundColor: Colors.white,
        radius: 35,
      ),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        side: const BorderSide(color: Colors.white, width: 3.0),
        padding: const EdgeInsets.all(8),
        primary: Colors.transparent,
      ),
    );
  }
}
