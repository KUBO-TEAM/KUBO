import 'package:flutter/material.dart';

class ScreenDarkEffect extends StatelessWidget {
  const ScreenDarkEffect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xCC000000),
            Color(0x00000000),
            Color(0x00000000),
            Color(0xCC000000),
          ],
        ),
      ),
    );
  }
}
