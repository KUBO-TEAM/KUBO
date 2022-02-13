import 'package:flutter/cupertino.dart';

class AppbarClipper extends StatelessWidget {
  const AppbarClipper({Key? key,
    required this.color
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _Clipper(),
      child: Container(
        color: color,
      ),
    );
  }
}


class _Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(80, 0);
    path.lineTo(80, 60 - 30);
    path.quadraticBezierTo(80, 60, 80 + 30, 60);
    path.lineTo(size.width, 60);
    path.lineTo(size.width, 0);

    path.moveTo(60, 0);
    path.lineTo(80, 0);
    path.lineTo(80, 25);
    path.lineTo(60, 25);
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