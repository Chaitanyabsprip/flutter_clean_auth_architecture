import '../../../../../UI/components/onboarding_page_content.dart';
import '../components/auth_page_heading.dart';
import '../components/signin_buttons.dart';
import 'signin_with_email.dart';
import '../../signin_bloc/sign_in_bloc.dart';
import '../../signin_bloc/sign_in_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late bool _useEmailSignIn;
  late final SignInBloc _signInBloc;

  @override
  void initState() {
    super.initState();
    _useEmailSignIn = false;
    _signInBloc = BlocProvider.of<SignInBloc>(context);
  }

  @override
  void dispose() {
    _signInBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (_useEmailSignIn) {
            _useEmailSignIn = false;
            return false;
          }
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              LogoAndTS(),
              !_useEmailSignIn ? _signInGeneral() : SignInWithEmail(),
              if (_useEmailSignIn)
                Positioned(
                  top: 8.0,
                  left: 8.0,
                  child: IconButton(
                    iconSize: 30,
                    icon: Icon(Icons.arrow_back, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _useEmailSignIn = false;
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeActiveWidget() {
    setState(() {
      _useEmailSignIn = !_useEmailSignIn;
    });
  }

  Widget _signInGeneral() {
    final SignInBloc signInBloc = BlocProvider.of<SignInBloc>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        AuthPageHeading(key: Key("Sign In"), title: "Sign In"),
        Row(
          key: Key("underline"),
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: Color(0xFFFF89C2),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 8,
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GoogleSignInButton(
                onPressed: () async {
                  print("SIGN IN: attemting sign in with google");
                  signInBloc.add(SignInWithGooglePressed());
                },
              ),
              EmailSignInButton(
                onPressed: () async {
                  _changeActiveWidget();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
