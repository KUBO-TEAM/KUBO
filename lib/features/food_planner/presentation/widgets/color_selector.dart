import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:kubo/core/constants/text_styles_constants.dart';
import 'package:kubo/features/food_planner/presentation/widgets/picker_card.dart';

class ColorSelector extends StatefulWidget {
  const ColorSelector({
    this.initialColor,
    Key? key,
    required this.onColorPicked,
  }) : super(key: key);

  final Function(Color?) onColorPicked;
  final Color? initialColor;

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  Color? selectedColor;

  void changeColor(Color color) {
    setState(() => selectedColor = color);
    widget.onColorPicked(color);
  }

  @override
  Widget build(BuildContext context) {
    final selectedColorOrInitialColor = selectedColor ?? widget.initialColor;
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
              child: HueRingPicker(
                pickerColor: selectedColorOrInitialColor ?? Colors.white,
                onColorChanged: changeColor,
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Got it'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
      child: PickerCard(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 50.0,
              width: 16.0,
              color: selectedColorOrInitialColor,
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 8.0,
                  ),
                  child: Text(
                    "Pick a Color",
                    style: kCaptionTextStyle.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 50.0,
              width: 16.0,
              color: selectedColorOrInitialColor,
            ),
          ],
        ),
      ),
    );
  }
}
