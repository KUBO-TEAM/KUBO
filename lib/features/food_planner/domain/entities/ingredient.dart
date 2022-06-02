import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'ingredient.g.dart';

@HiveType(typeId: 3)
class Ingredient extends Equatable {
  const Ingredient({
    required this.name,
    required this.quantity,
  });

  @HiveField(1)
  final String name;
  @HiveField(2)
  final double quantity;

  @override
  List<Object?> get props => [
        name,
        quantity,
      ];
}
