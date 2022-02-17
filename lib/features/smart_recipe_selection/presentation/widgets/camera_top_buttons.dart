import 'package:flutter/material.dart';
import 'package:kubo/features/food_planner/presentation/widgets/icon_button.dart';

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
