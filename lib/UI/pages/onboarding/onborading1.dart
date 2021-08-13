import 'package:flutter/material.dart';

import '../../components/background_clipper.dart';

class Onboarding1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 590,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: BackgroundClipper(),
                    child: Container(
                      width: 400,
                      height: 260,
                      color: Color(0xFF7F2982),
                    ),
                  ),
                  Positioned(
                    child: Text('Track Your',
                        style: Theme.of(context).textTheme.headline2),
                    left: 150,
                    top: 70,
                  ),
                  Positioned(
                    child: Text('Periods',
                        style: Theme.of(context).textTheme.headline1),
                    left: 133,
                    top: 110,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
