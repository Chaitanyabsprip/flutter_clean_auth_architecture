import '../../authentication_bloc/authentication_bloc.dart';
import '../../authentication_bloc/authentication_events.dart';
import '../../signin_bloc/sign_in_bloc.dart';
import '../../signin_bloc/sign_in_events.dart';
import '../../signin_bloc/sign_in_states.dart';
import '../../signup_bloc/sign_up_bloc.dart';
import '../../signup_bloc/sign_up_events.dart';
import '../../signup_bloc/sign_up_states.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loggy/loggy.dart';

class SignInWithEmail extends StatefulWidget {
  const SignInWithEmail({Key? key}) : super(key: key);

  @override
  _SignInWithEmailState createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> with UiLoggy {
  late bool _signUpSelected;
  late final int _animationDuration;

  @override
  void initState() {
    super.initState();
    _signUpSelected = false;
    _animationDuration = 200;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        _buildTabs(),
        Row(
          key: Key("underline"),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Color(0xFFFF89C2),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 2,
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        !_signUpSelected ? SignInForm() : SignUpForm(),
      ],
    );
  }

  Container _buildTabs() {
    loggy.debug("Building Sign In/Sign Up tabs");
    return Container(
      height: 70.0,
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildAnimatedButton(
            condition: !_signUpSelected,
            label: "Sign In",
            padding: EdgeInsets.only(right: 4.0, bottom: 4.0),
            onPressed: () {
              if (_signUpSelected) {
                _signUpSelected = !_signUpSelected;
                setState(() {});
              }
            },
          ),
          _buildAnimatedButton(
            condition: _signUpSelected,
            label: "Sign Up",
            padding: EdgeInsets.only(left: 4.0, bottom: 4.0),
            onPressed: () {
              if (!_signUpSelected) {
                _signUpSelected = !_signUpSelected;
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }

  AnimatedContainer _buildAnimatedButton({
    required bool condition,
    required void Function()? onPressed,
    required String label,
    required EdgeInsets padding,
  }) {
    loggy.debug("Building $label animated button");
    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      padding: padding,
      height: condition ? 70.0 : 60.0,
      duration: Duration(milliseconds: _animationDuration),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: Color(0xFFCFCFCF),
            fontSize: condition ? 40 : 24,
          ),
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> with UiLoggy {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final SignInBloc _signInBloc;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _signInBloc = BlocProvider.of<SignInBloc>(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _signInBloc,
      listener: (BuildContext context, SignInState state) {
        if (state is SignInError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 2,
                backgroundColor: Color(0x88CFCFCF),
                behavior: SnackBarBehavior.floating,
                // width: MediaQuery.of(context).size.width * 0.6,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.message,
                      style: TextStyle(fontSize: 11.0, color: Colors.black),
                    ),
                    Icon(Icons.error),
                  ],
                ),
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.8,
                  left: MediaQuery.of(context).size.width * 0.10,
                  right: MediaQuery.of(context).size.width * 0.1,
                ),
                // padding: EdgeInsets.all(4.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
            );
        }
        if (state.isSubmitting) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Signing In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state is SignInSuccess) {
          // TODO: abstract authentication bloc call behind signin_bloc
          BlocProvider.of<AuthenticationBloc>(context)
              .add(LoggedIn(user: state.user));
        }
      },
      child: BlocBuilder<SignInBloc, SignInState>(
        bloc: _signInBloc,
        builder: (BuildContext context, SignInState state) {
          return Form(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 76.0),
                  CredentialInputField(
                    controller: _emailController,
                    labelText: "Email",
                    icon: Icons.email_rounded,
                  ),
                  SizedBox(height: 16.0),
                  CredentialInputField(
                    obscureText: true,
                    controller: _passwordController,
                    icon: Icons.lock,
                    labelText: "Password",
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  ElevatedButton(
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text("Sign In"),
                    ),
                    onPressed: () {
                      loggy.info("Sign In with email button pressed");
                      _signInBloc.add(
                        SignInWithCredentialsPressed(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 64.0),
                  Text("Trouble signing in?"),
                  SizedBox(height: 24.0),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Create Account",
                          style: TextStyle(
                            color: Color(0xFFFF0099),
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(text: " Or "),
                        TextSpan(
                          text: "Forgot Password",
                          style: TextStyle(
                            color: Color(0xFFFF0099),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _signInBloc.add(
                                ForgotPasswordButtonPressed(
                                  email: _emailController.text,
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final SignUpBloc _signUpBloc;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      bloc: _signUpBloc,
      listener: (BuildContext context, SignUpState state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Sign Up Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Signing Up...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state is SignInSuccess) {
          // TODO: abstract authentication bloc call behind signin_bloc
          BlocProvider.of<AuthenticationBloc>(context).add(
            LoggedIn(user: (state as SignInSuccess).user),
          );
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        bloc: _signUpBloc,
        builder: (context, state) {
          return Form(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CredentialInputField(
                    controller: _emailController,
                    labelText: "Email",
                    icon: Icons.email_rounded,
                  ),
                  SizedBox(height: 16.0),
                  CredentialInputField(
                    obscureText: true,
                    controller: _passwordController,
                    labelText: "Password",
                    icon: Icons.lock_rounded,
                  ),
                  SizedBox(height: 16.0),
                  CredentialInputField(
                    obscureText: true,
                    controller: _confirmPasswordController,
                    labelText: "Confirm Password",
                    icon: Icons.lock_rounded,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  ElevatedButton(
                    child: Text("Sign Up"),
                    onPressed: () {
                      _signUpBloc.add(
                        SignUpButtonPressed(
                          email: _emailController.text,
                          password: _passwordController.text,
                          confirmPassword: _confirmPasswordController.text,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CredentialInputField extends StatelessWidget {
  final TextEditingController _controller;
  final IconData _icon;
  final String _labelText;
  final bool _obscureText;
  const CredentialInputField({
    Key? key,
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
  })  : _controller = controller,
        _labelText = labelText,
        _icon = icon,
        _obscureText = obscureText,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 60,
      child: TextFormField(
        controller: _controller,
        obscureText: _obscureText,
        decoration: _buildInputDecoration(
          icon: _icon,
          labelText: _labelText,
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String labelText,
    required IconData icon,
  }) {
    return InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Color(0xFFCFCFCF),
      ),
      border: InputBorder.none,
      labelText: labelText,
      labelStyle: TextStyle(
        color: Color(0xFF8F8F8F),
      ),
    );
  }
}
