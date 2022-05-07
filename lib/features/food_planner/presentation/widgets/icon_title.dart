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
          radius: 16,
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
            color: kGreenPrimary,
            fontFamily: 'Montserrat Medium',
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
