import 'package:flutter/material.dart';

class WelcomeClipper extends StatelessWidget {
  const WelcomeClipper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _Clipper(),
      child: Container(
        color: Colors.white,
      ),
    );
  }
}

class _Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height);
    path.lineTo(12, size.height);
    path.lineTo(12, 0);

    double startingHeight = size.height * 0.55;
    int boxHeight = 250;
    path.moveTo(12, startingHeight);
    path.lineTo(size.width - 60, startingHeight);
    path.quadraticBezierTo(
      size.width,
      startingHeight,
      size.width,
      startingHeight + 60,
    );

    path.lineTo(size.width, startingHeight + boxHeight - 60);
    path.lineTo(12, startingHeight + boxHeight);

    path.moveTo(12, startingHeight + boxHeight);
    path.lineTo(size.width - 60, startingHeight + boxHeight);
    path.quadraticBezierTo(
      size.width,
      startingHeight + boxHeight,
      size.width,
      startingHeight + boxHeight - 60,
    );

    path.moveTo(12, startingHeight - 35);
    path.lineTo(12, startingHeight);
    path.lineTo(52, startingHeight);
    path.lineTo(52, startingHeight - 35);
    path.lineTo(52, startingHeight);
    path.quadraticBezierTo(
      12,
      startingHeight,
      12,
      startingHeight - 35,
    );

    path.moveTo(12, startingHeight + boxHeight + 35);
    path.lineTo(12, startingHeight + boxHeight);
    path.lineTo(52, startingHeight + boxHeight);
    path.lineTo(52, startingHeight + boxHeight + 35);
    path.lineTo(52, startingHeight + boxHeight);
    path.quadraticBezierTo(
      12,
      startingHeight + boxHeight,
      12,
      startingHeight + boxHeight + 35,
    );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
