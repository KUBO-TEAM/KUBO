import 'package:flutter/material.dart';


class ListClipper extends StatelessWidget {
  const ListClipper({Key? key,
    this.color}) : super(key: key);

  final Color? color;


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

    path.moveTo(0, 0);
    path.lineTo(50, 0);
    path.quadraticBezierTo(80, 0, 80 , 35);
    path.quadraticBezierTo(80, 70, 80 + 35 , 70);

    path.lineTo(size.width - 35 , 70);
    path.quadraticBezierTo(size.width , 70, size.width , 70 + 35);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}