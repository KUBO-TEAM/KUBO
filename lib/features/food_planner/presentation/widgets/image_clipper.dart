import 'package:flutter/material.dart';

class ImageClipper extends StatelessWidget {
  const ImageClipper({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _Clipper(),
      child: Container(
        child: child,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .4,
        color: const Color(0xffF0DEC3),
      ),
    );
  }
}

class _Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(10, 0);
    path.lineTo(10, size.height - 100);
    path.quadraticBezierTo(10, size.height - 50, 60, size.height - 50);

    path.lineTo(size.width - 50, size.height - 50);
    path.quadraticBezierTo(
        size.width, size.height - 50, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
