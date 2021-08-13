import '../../components/auth_bg.dart';
import '../../components/auth_buttons.dart';
import '../../components/page_heading.dart';
import 'package:flutter/material.dart';

import '../../components/logo.dart';
import '../../components/terms_and_service.dart';

class AuthPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Logo(),
            SizedBox(width: 24.0),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.25),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 24.0),
            PageHeading(text: 'Sign In'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              color: Color(0xFFFF89C2),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 8,
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.16),
        AuthButtons(),
      ],
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AuthBg(color: Color(0xFF000000)),
          AuthPageContent(),
          Positioned(
            left: 1.0,
            right: 1.0,
            bottom: 8.0,
            child: TermsAndService(),
          ),
        ],
      ),
    );
  }
}
