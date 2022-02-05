import 'package:flutter/material.dart';

class Schedule {
  Schedule({
    required this.recipeId,
    required this.recipeName,
    required this.start,
    required this.end,
    required this.backgroundColor,
    this.isAllDay = false,
  });

  String recipeId;
  String recipeName;
  DateTime start;
  DateTime end;
  Color backgroundColor;
  bool isAllDay;
}
