import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.title,
    this.color = kBrownPrimary,
    required this.onPressed,
    this.elevation = 5.0,
  }) : super(key: key);

  final Text title;
  final Function() onPressed;
  final Color color;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: title,
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color,
        onPrimary: Colors.white,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );
  }
}
