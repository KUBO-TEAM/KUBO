import 'package:flutter/material.dart';

class CameraClipper extends StatelessWidget {
  const CameraClipper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _Clipper(),
      child: Container(
        color: Colors.black,
      ),
    );
  }
}

class _Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(80, 0);
    path.lineTo(80, 80 - 50);
    path.quadraticBezierTo(80, 80, 80 + 50, 80);
    path.lineTo(size.width, 80);
    path.lineTo(size.width, 0);

    path.moveTo(50, 0);
    path.lineTo(80, 0);
    path.lineTo(80, 25);
    path.lineTo(50, 25);
    path.lineTo(80, 25);
    path.quadraticBezierTo(
      80,
      0,
      50,
      0,
    );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
