import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsAndService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Text.rich(
          TextSpan(
            text: 'By continuing, you agree to our ',
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF5B5B5B),
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Terms of Service',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFFFF0099),
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // code to open / launch terms of service link here
                  },
              ),
              TextSpan(
                  text: ' and ',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF5B5B5B),
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFFFF0099),
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // code to open / launch privacy policy link here
                          })
                  ])
            ],
          ),
          softWrap: true,
        ),
      ),
    );
  }
}
