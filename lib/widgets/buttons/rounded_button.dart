import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final Function() onPressed;

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
        primary: const Color(0xff371D10),
        onPrimary: Colors.white,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );
  }
}
