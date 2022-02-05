import 'package:flutter/material.dart';

class Schedule {
  Schedule({
    required this.recipeId,
    required this.recipeName,
    required this.recipeDescription,
    required this.recipeImageUrl,
    required this.start,
    required this.end,
    required this.backgroundColor,
    this.isAllDay = false,
  });

  String recipeId;
  String recipeName;
  String recipeDescription;
  String recipeImageUrl;

  DateTime start;
  DateTime end;
  Color backgroundColor;
  bool isAllDay;
}
