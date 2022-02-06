import 'package:flutter/material.dart';

class Schedule {
  const Schedule({
    required this.recipeId,
    required this.recipeName,
    required this.recipeDescription,
    required this.recipeImageUrl,
    required this.start,
    required this.end,
    required this.backgroundColor,
    this.isAllDay = false,
  });

  final String recipeId;
  final String recipeName;
  final String recipeDescription;
  final String recipeImageUrl;

  final DateTime start;
  final DateTime end;
  final Color backgroundColor;
  final bool isAllDay;
}
