import 'package:flutter/material.dart';

class AuthPageHeading extends StatelessWidget {
  final String title;
  const AuthPageHeading({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(left: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 70,
          fontWeight: FontWeight.w600,
          color: Color(0xFFCFCFCF),
        ),
      ),
    );
  }
}
