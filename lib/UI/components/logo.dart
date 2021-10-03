
import 'dart:math' show pi;

import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final TextStyle style;
  final Color color;
  final double height;
  final double width;
  final double angle;

  Logo({
    this.angle = pi,
    this.padding = const EdgeInsets.only(
      left: 8.0,
      right: 8.0,
      top: 0.0,
      bottom: 16.00,
    ),
    this.margin: const EdgeInsets.only(
      left: 24.0,
      right: 0.0,
      top: 0.0,
      bottom: 0.00,
    ),
    this.height = 40,
    this.width = 120,
    this.style = const TextStyle(
      fontFamily: "Roboto",
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      letterSpacing: 1.1,
    ),
    this.color = const Color(0xFFFF89C2),
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      child: Container(
        height: height,
        width: width,
        padding: padding,
        color: color,
        child: Text(
          "Crimson",
          style: style,
        ),
      ),
      angle: angle,
    );
  }
}
