import 'package:flutter/material.dart';
import 'package:kubo/constants/colors_constants.dart';
import 'package:kubo/modules/camera/states/camera.state.dart';

class CameraPage extends StatelessWidget {
  static const String id = 'camera_page';
  const CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kBrownPrimary,
      body: SafeArea(child: CameraState()),
    );
  }
}
