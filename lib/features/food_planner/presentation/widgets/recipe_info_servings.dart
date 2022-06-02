import 'package:flutter/material.dart';

class RecipeInfoServings extends StatefulWidget {
  const RecipeInfoServings({
    Key? key,
    required this.icon,
    required this.servings,
    required this.color,
    required this.onChange,
    this.title = "",
  }) : super(key: key);

  final IconData icon;
  final int servings;
  final String title;
  final Color color;
  final ValueChanged<int> onChange;

  @override
  State<RecipeInfoServings> createState() => _RecipeInfoServingsState();
}

class _RecipeInfoServingsState extends State<RecipeInfoServings> {
  int serviceCounter = 0;
  @override
  void initState() {
    super.initState();

    serviceCounter = widget.servings;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (serviceCounter >= 2)
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              if (serviceCounter >= 2) {
                setState(() {
                  serviceCounter--;
                });

                widget.onChange(serviceCounter);
              }
            },
            icon: const Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
              size: 25.0,
            ),
          ),
        Icon(
          widget.icon,
          color: widget.color,
        ),
        Text(
          ' ${serviceCounter.toString()} ${widget.title}',
          style: TextStyle(
            color: widget.color,
            fontSize: 14.0,
            fontFamily: 'Montserrat Medium',
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              serviceCounter++;
            });

            widget.onChange(serviceCounter);
          },
          icon: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.black,
            size: 25.0,
          ),
        ),
      ],
    );
  }
}
