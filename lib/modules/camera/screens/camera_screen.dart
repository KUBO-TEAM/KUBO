import 'dart:math';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:kubo/widgets/clippers/camera.clipper.dart';

class CameraScreen extends StatelessWidget {
  static const String id = 'camera_screen';
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double kScreenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Stack(
        children: [
          const _Camera(),
          Positioned(
            bottom: 20,
            left: (kScreenWidth / 2) - 35,
            child: ElevatedButton(
              onPressed: () {},
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 35,
              ),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(8),
                primary: Colors.grey, // <-- Button colorr
              ),
            ),
          ),
          const CameraClipper(),
        ],
      ),
    );
  }
}

class _Camera extends StatefulWidget {
  const _Camera({Key? key}) : super(key: key);

  @override
  State<_Camera> createState() => _CameraState();
}

class _CameraState extends State<_Camera> {
  late CameraController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCameras();
  }

  @override
  void dispose() {
    if (controller != null) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> getCameras() async {
    List<CameraDescription> cameras;

    cameras = await availableCameras();

    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    try {
      return SizedBox(
        width: double.infinity,
        child: CameraPreview(controller),
      );
    } catch (e) {
      return Container();
    }
  }
}
