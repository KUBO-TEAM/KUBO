import 'package:flutter/material.dart';

class RecipeClipper extends StatelessWidget {
  const RecipeClipper({Key? key}) : super(key: key);

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

    final double startingHeight = size.height;

    path.lineTo(0, size.height);
    path.lineTo(10, size.height);
    path.lineTo(10, 0);

    path.moveTo(0, startingHeight);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.moveTo(10, startingHeight - 60);
    path.lineTo(10, startingHeight);
    path.lineTo(60, startingHeight);
    path.quadraticBezierTo(
      10,
      startingHeight,
      10,
      startingHeight - 50,
    );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
