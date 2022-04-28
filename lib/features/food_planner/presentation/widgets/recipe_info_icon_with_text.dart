import 'package:flutter/material.dart';

class RecipeInfoIconWithText extends StatelessWidget {
  const RecipeInfoIconWithText({
    Key? key,
    required this.icon,
    required this.data,
    this.title = "",
  }) : super(key: key);

  final IconData icon;
  final String data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        Text(
          ' $data $title',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}
