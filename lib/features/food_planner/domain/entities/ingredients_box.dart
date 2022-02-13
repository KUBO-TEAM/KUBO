import 'package:equatable/equatable.dart';

class IngredientsBox extends Equatable {
  const IngredientsBox({
    required this.id,
    required this.ingredients,
    required this.isExpanded,
  });

  final String id;
  final List<String> ingredients;
  final bool isExpanded;

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        ingredients,
        isExpanded,
      ];
}
