import 'dart:math';

import 'package:flutter/material.dart';

import '../components/logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Logo(
          angle: pi / 2,
        ),
      ),
    );
  }
}
