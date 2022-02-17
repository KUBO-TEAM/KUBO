import 'package:flutter/material.dart';

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
