import 'package:flutter/material.dart';

class RecipeInfoIconWithText extends StatelessWidget {
  const RecipeInfoIconWithText({
    Key? key,
    required this.icon,
    required this.data,
    required this.color,
    this.title = "",
  }) : super(key: key);

  final IconData icon;
  final String data;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        Text(
          ' $data $title',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}
