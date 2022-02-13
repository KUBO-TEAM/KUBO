import 'package:flutter/material.dart';

class CostumeIconButton extends StatefulWidget {
  const CostumeIconButton({
    Key? key,
    required this.icon,
    this.pressedIcon,
    required this.onPressed,
  }) : super(key: key);

  final Icon icon;
  final Icon? pressedIcon;
  final Function onPressed;

  @override
  _CostumeIconButton createState() => _CostumeIconButton();
}

class _CostumeIconButton extends State<CostumeIconButton> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (widget.pressedIcon != null) {
          setState(() {
            status = !status;
          });
        }

        widget.onPressed();
      },
      child: widget.pressedIcon == null
          ? widget.icon
          : status
              ? widget.icon
              : widget.pressedIcon!,
    );
  }
}
