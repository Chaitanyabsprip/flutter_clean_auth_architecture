import '../pages/sign_in/sign_in.dart';

import '../../core/authentication/PLoC/sign_in_bloc.dart';
import '../../core/authentication/PLoC/sign_in_states.dart';
import '../../core/authentication/domain/usecase/authentication_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter/material.dart';

class AuthButtons extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GoogleSignInButton(),
            EmailSignInButton(),
          ],
        ),
      ],
    );
  }
}

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
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: Text(
        'Google',
        style: TextStyle(
          fontFamily: "Monstserrat",
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: Color(0xFF939393),
        ),
      ),
      icon: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          "assets/icons/google_logo.png",
          width: 28,
          height: 28,
        ),
      ),
      onPressed: () async {},
    );
  }
}

class EmailSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: Text(
        'Email',
        style: TextStyle(
          fontFamily: "Monstserrat",
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: Color(0xFF939393),
        ),
      ),
      icon: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          "assets/icons/Email.png",
          width: 28,
          height: 28,
        ),
      ),
      onPressed: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider<SignInBloc>(
              create: (context) => SignInBloc(
                authenticationUsecase: GetIt.I.get<Authentication>(),
                initialState: SignInState.empty(),
              ),
              child: SignInPage(),
            ),
          ),
        );
      },
    );
  }
}

class AppleIdSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: Text(
        'Apple Id',
        style: TextStyle(
          fontFamily: "Monstserrat",
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: Color(0xFF939393),
        ),
      ),
      icon: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          "assets/icons/apple.png",
          width: 28,
          height: 28,
        ),
      ),
      onPressed: () async {
        print('apple');
      },
    );
  }
}
