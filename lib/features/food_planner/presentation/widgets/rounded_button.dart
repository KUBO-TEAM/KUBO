import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.title,
    this.color = kBrownPrimary,
    required this.onPressed,
    this.elevation = 5.0,
    this.icon,
  }) : super(key: key);

  final Text title;
  final Function() onPressed;
  final Color color;
  final double elevation;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    if (icon is Icon) {
      return ElevatedButton.icon(
        label: title,
        icon: icon as Icon,
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
