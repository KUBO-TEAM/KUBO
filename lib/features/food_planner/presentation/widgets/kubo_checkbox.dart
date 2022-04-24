import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/data/models/ingredient_model.dart';

class KuboCheckBox extends StatefulWidget {
  const KuboCheckBox({
    Key? key,
    required this.ingredient,
  }) : super(key: key);

  final IngredientModel ingredient;

  @override
  State<KuboCheckBox> createState() => _KuboCheckBoxState();
}

class _KuboCheckBoxState extends State<KuboCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      return kBrownPrimary;
    }

    return Row(
      children: [
        SizedBox(
          height: 30.0,
          width: 40.0,
          child: Checkbox(
            value: isChecked,
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
        ),
        Text(
          '${widget.ingredient.quantity} ${widget.ingredient.name}',
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
