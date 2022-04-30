import 'package:flutter/material.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({Key? key, required this.recipe}) : super(key: key);

  final Recipe recipe;

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 20.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
