import 'package:flutter/material.dart';

class CustomShape extends CustomClipper<Path> {
  const CustomShape();

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, 50);
    path.lineTo(0, 20);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}
