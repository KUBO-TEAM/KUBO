import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/constants/text_styles.constants.dart';
import 'package:kubo/widgets/cards/picker.card.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorSelector extends StatefulWidget {
  const ColorSelector({
    Key? key,
    required this.onColorPicked,
  }) : super(key: key);

  final Function(Color?) onColorPicked;

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  Color pickerColor = kGreenPrimary;
  Color currentColor = kGreenPrimary;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        void changeColor(Color color) {
          setState(() => pickerColor = color);
          widget.onColorPicked(color);
        }

        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
              child: HueRingPicker(
                pickerColor: pickerColor,
                onColorChanged: changeColor,
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Got it'),
                onPressed: () {
                  setState(() => currentColor = pickerColor);
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
              color: currentColor,
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
              color: currentColor,
            ),
          ],
        ),
      ),
    );
  }
}