import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';

class CameraClipper extends StatelessWidget {
  const CameraClipper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _Clipper(),
      child: Container(
        color: Colors.black.withOpacity(.7),
      ),
    );
  }
}

class _Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(80, 0);
    path.lineTo(80, 65 - 30);
    path.quadraticBezierTo(80, 65, 80 + 30, 65);
    path.lineTo(size.width, 65);
    path.lineTo(size.width, 0);

    path.moveTo(65, 0);
    path.lineTo(80, 0);
    path.lineTo(80, 25);
    path.lineTo(65, 25);
    path.lineTo(80, 25);
    path.quadraticBezierTo(
      80,
      0,
      60,
      0,
    );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
