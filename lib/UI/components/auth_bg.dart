import 'package:flutter/material.dart';

class AuthBg extends StatefulWidget {
  final Color color;
  AuthBg({
    this.color = const Color(0xFFFFFFFF),
  });
  @override
  State<StatefulWidget> createState() => _AuthBg();
}

class _AuthBg extends State<AuthBg> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      height: double.infinity,
      width: double.infinity,
    );
  }
}
