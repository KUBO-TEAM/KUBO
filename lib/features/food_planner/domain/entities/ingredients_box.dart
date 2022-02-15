import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class IngredientsBox extends Equatable {
  IngredientsBox({
    required this.id,
    required this.ingredients,
    this.isExpanded = false,
  });

  final String id;
  final List<String> ingredients;
  bool isExpanded;

  @override
  List<Object?> get props => [id, ingredients];
}
