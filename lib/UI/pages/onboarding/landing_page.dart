import 'package:flutter/material.dart';

import '../../components/background_clipper.dart';
import 'onborading1.dart';

class LandingPage extends StatelessWidget {
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
                    clipper: const BackgroundClipper(),
                    child: Container(
                      width: 400,
                      height: 260,
                      color: Color(0xFF7F2982),
                    ),
                  ),
                  Positioned(
                    child: Text(
                      'Track Your',
                      style: TextStyle(
                        fontSize: 60,
                        color: Color(0xFFE0E0E0),
                      ),
                    ),
                    left: 60,
                    top: 50,
                  ),
                  Positioned(
                    child: Text(
                      'Periods',
                      style: TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.w100,
                        color: Color(0xFFE0E0E0),
                      ),
                    ),
                    left: 45,
                    top: 110,
                  ),
                  SizedBox(height: 10),
                  Positioned(
                    bottom: 0.0,
                    left: MediaQuery.of(context).size.width * 0.09,
                    child: Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width * 0.82,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFFEBCACA)),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 150,
                    child: Image(
                      width: 115,
                      image: AssetImage('assets/images/OBJECTS.png'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.82,
              padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
              child: Text(
                  'It’s time to start a journey towards a happier and healthier you',
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            SizedBox(
              height: 32,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Color(0xFF7F2982),
              child: SizedBox(
                width: 140,
                child: Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Onboarding1(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
