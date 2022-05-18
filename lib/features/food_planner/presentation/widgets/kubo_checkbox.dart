import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/smart_recipe_selection/data/models/category_model.dart';

class KuboCheckBox extends StatefulWidget {
  const KuboCheckBox({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryModel category;

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
          '1 ${widget.category.name}',
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
