import 'package:flutter/material.dart';

class BackgroundClipper extends CustomClipper<Path> {
  const BackgroundClipper();

  @override
  Path getClip(Size size) {
    var w = size.width;
    var h = size.height;
    var controlPoint1 = Offset(w - 40, h - 75);
    var controlPoint2 = Offset(40, h - 10);
    var endPoint = Offset(0, 175);
    final path = Path()
      ..moveTo(0, 175)
      ..lineTo(0, 0)
      ..lineTo(w, 0)
      ..lineTo(w, h)
      ..cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
          controlPoint2.dy, endPoint.dx, endPoint.dy)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
