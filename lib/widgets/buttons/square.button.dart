import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/widgets/cards/picker.card.dart';

class SquareButton extends StatelessWidget {
  const SquareButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: PickerCard(
        child: Container(
          width: double.infinity,
          color: kBrownPrimary,
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          child: const Center(
            child: Text(
              'Save Schedule',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
