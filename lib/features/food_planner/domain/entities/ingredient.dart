import 'package:equatable/equatable.dart';

class Ingredient extends Equatable {
  const Ingredient({
    required this.name,
    required this.quantity,
    required this.dateCreated,
  });

  final String name;
  final int quantity;
  final DateTime dateCreated;

  @override
  List<Object?> get props => [
        name,
        quantity,
        dateCreated,
      ];
}
