import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final void Function()? onPressed;
  SignInButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(
        label,
        style: TextStyle(
          fontFamily: "Monstserrat",
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: Color(0xFF939393),
        ),
      ),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  final void Function()? onPressed;

  GoogleSignInButton({
    Key? key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SignInButton(
      key: key,
      label: "Google",
      onPressed: onPressed,
      icon: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          "assets/icons/google_logo.png",
          width: 28,
          height: 28,
        ),
      ),
    );
  }
}

class EmailSignInButton extends StatelessWidget {
  final void Function()? onPressed;

  const EmailSignInButton({
    required this.onPressed,
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return SignInButton(
      key: key,
      label: "Email",
      onPressed: onPressed,
      icon: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          "assets/icons/Email.png",
          width: 28,
          height: 28,
        ),
      ),
    );
  }
}
