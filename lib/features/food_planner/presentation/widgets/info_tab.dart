import 'package:flutter/material.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';

class InfoTab extends StatelessWidget {
  const InfoTab({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 20.0,
      ),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Text(
          '\t\t\t\t${recipe.description}',
          style: const TextStyle(
            fontSize: 16.0,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
