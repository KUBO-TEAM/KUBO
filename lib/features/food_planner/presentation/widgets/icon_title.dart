import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';

class IconTitle extends StatelessWidget {
  const IconTitle({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: kGreenPrimary,
          child: Icon(
            icon,
            size: 16.0,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            color: kGreenPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
