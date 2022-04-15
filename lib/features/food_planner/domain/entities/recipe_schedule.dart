import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RecipeSchedule extends Equatable {
  final String id;
  final String name;
  final String description;
  final String displayPhoto;
  final DateTime start;
  final DateTime end;
  final Color color;
  final bool isAllDay;

  const RecipeSchedule({
    required this.id,
    required this.name,
    required this.description,
    required this.displayPhoto,
    required this.start,
    required this.end,
    required this.color,
    required this.isAllDay,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        displayPhoto,
        start,
        end,
        color,
        isAllDay,
      ];
}
