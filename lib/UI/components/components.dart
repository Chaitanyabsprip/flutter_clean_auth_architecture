import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final Widget child;
  final Widget leading;
  final Function onPressed;
  final bool raised;

  RoundButton({
    required this.child,
    required this.onPressed,
    Key? key,
    required this.leading,
    bool raised = false,
  })  : raised = raised,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: raised
          ? raisedButton(
              child,
              onPressed,
            )
          : flatButton(
              child,
              onPressed,
            ),
    );
  }

  Widget raisedButton(
    Widget child,
    Function onPressed,
  ) =>
      RaisedButton(
        textColor: Colors.black,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            leading,
            child,
          ],
        ),
        onPressed: onPressed(),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
      );

  Widget flatButton(
    Widget child,
    Function onPressed,
  ) =>
      TextButton(
        child: Row(
          children: <Widget>[
            leading,
            child,
          ],
        ),
        onPressed: onPressed(),
        style: ButtonStyle(),
      );
}
