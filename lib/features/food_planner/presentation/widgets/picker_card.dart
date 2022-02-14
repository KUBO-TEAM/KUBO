import 'package:flutter/material.dart';
import 'package:kubo/core/constants/decoration_constants.dart';

class PickerCard extends StatelessWidget {
  const PickerCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kShadowPrimary,
      child: Card(child: child),
    );
  }
}
