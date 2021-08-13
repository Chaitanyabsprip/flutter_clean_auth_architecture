import 'package:flutter/material.dart';

import 'logo.dart';
import 'terms_and_service.dart';

class OnBoardingPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: SignInWithEmailPageLayoutDelegate(),
      children: <Widget>[
        LayoutId(
          id: 'logo',
          child: Logo(),
        ),
        LayoutId(
          child: TermsAndService(),
          id: 'terms_and_service',
        )
      ],
    );
  }
}

class SignInWithEmailPageLayoutDelegate extends MultiChildLayoutDelegate {
  SignInWithEmailPageLayoutDelegate({this.position});

  final Offset? position;
  @override
  void performLayout(Size size) {
    if (hasChild('logo')) {
      final logoSize = layoutChild('logo', BoxConstraints());
      positionChild(
        'logo',
        Offset(
          size.width - (logoSize.width + 24.0),
          0.0,
        ),
      );
    }
    if (hasChild('terms_and_service')) {
      final textSize = layoutChild('terms_and_service', BoxConstraints());
      positionChild(
        'terms_and_service',
        Offset(
          (size.width - textSize.width) / 2,
          size.height - textSize.height - 16,
        ),
      );
    }
  }

  @override
  bool shouldRelayout(SignInWithEmailPageLayoutDelegate oldDelegate) {
    return oldDelegate.position != position;
  }
}
