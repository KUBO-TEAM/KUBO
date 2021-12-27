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

    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  Future<XFile?> _takePicture() async {
    final CameraController? cameraController = controller;
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

  @override
  Widget build(BuildContext context) {
    double kScreenWidth = MediaQuery.of(context).size.width;
    if (controller != null) {
      return Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: CameraPreview(controller!),
          ),
          Positioned(
            bottom: 20,
            left: (kScreenWidth / 2) - 35,
            child: CameraCircleButton(
              onPressed: _onTakePictureButtonPressed,
            ),
          ),
          const CameraClipper(),
          const CameraTopButtons(),
        ],
      );
    }
    return Container();
  }
}

class CameraTopButtons extends StatelessWidget {
  const CameraTopButtons({
    Key? key,
  }) : super(key: key);

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
              size: 30.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CostumeIconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.flash_on,
              color: Colors.amber,
              size: 30.0,
            ),
            pressedIcon: const Icon(
              Icons.flash_off,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          CostumeIconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.hdr_on,
              color: Colors.amber,
              size: 50.0,
            ),
            pressedIcon: const Icon(
              Icons.hdr_off,
              color: Colors.white,
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
