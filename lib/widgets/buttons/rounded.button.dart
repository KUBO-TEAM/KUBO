import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.title,
    this.color = kBrownPrimary,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final Function() onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text(
        "Try Now",
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color,
        onPrimary: Colors.white,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );
  }
}
