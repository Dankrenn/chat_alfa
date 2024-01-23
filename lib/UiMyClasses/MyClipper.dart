import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(10, 0)
      ..lineTo(size.width - 10, 0)
      ..lineTo(size.width, 10)
      ..lineTo(size.width, size.height - 10)
      ..lineTo(size.width - 10, size.height)
      ..lineTo(10, size.height)
      ..lineTo(0, size.height - 10)
      ..lineTo(0, 10)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}