import 'package:flutter/material.dart';

class PageHeading extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  PageHeading({
    required this.text,
    this.fontSize = 80,
    this.color = const Color(0xFFCFCFCF),
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: this.color,
        fontFamily: "Nunito",
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
