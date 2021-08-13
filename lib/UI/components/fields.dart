import '../../core/authentication/PLoC/authentication_bloc.dart';
import '../../core/authentication/PLoC/authentication_events.dart';
import '../../core/authentication/PLoC/sign_in_bloc.dart';
import '../../core/authentication/PLoC/sign_in_events.dart';
import '../../core/authentication/PLoC/sign_in_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthFields extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthFieldsState();
}

class _AuthFieldsState extends State<AuthFields> {
  late SignInBloc _signInBloc;

  @override
  void initState() {
    super.initState();
    _signInBloc = BlocProvider.of<SignInBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return LoginForm();
  }

  @override
  void dispose() {
    _signInBloc.close();
    super.dispose();
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late SignInBloc _signInBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(SignInState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _signInBloc = BlocProvider.of<SignInBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _signInBloc,
      listener: (BuildContext context, SignInState state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
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
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<SignInBloc, SignInState>(
        bloc: _signInBloc,
        builder: (BuildContext context, SignInState state) {
          return Form(
            child: CustomMultiChildLayout(
              children: <Widget>[
                LayoutId(
                  id: 'emailTextField',
                  child: EmailField(controller: _emailController),
                ),
                LayoutId(
                  id: 'passwordTextField',
                  child: PasswordField(controller: _passwordController),
                ),
                LayoutId(
                  id: 'underline1',
                  child: Container(
                    color: Color(0x8F3F3F3F),
                    height: 2.0,
                    width: MediaQuery.of(context).size.width * 0.85,
                  ),
                ),
                LayoutId(
                  id: 'underline2',
                  child: Container(
                    color: Color(0x8F3F3F3F),
                    height: 2.0,
                    width: MediaQuery.of(context).size.width * 0.85,
                  ),
                )
              ],
              delegate: FieldsLayoutDelegate(),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _signInBloc.add(
      EmailChanged(_emailController.text),
    );
  }

  void _onPasswordChanged() {
    _signInBloc.add(
      PasswordChanged(_passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _signInBloc.add(
      SignInWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  final TextEditingController _emailController;

  const EmailField({
    Key? key,
    required TextEditingController controller,
  })  : _emailController = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      style: TextStyle(
        color: Color(
          0xFFCFCFCF,
        ),
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.email,
          color: Color(0xFFCFCFCF),
        ),
        labelText: "Email",
        labelStyle: TextStyle(
          color: Color(0xFF8F8F8F),
        ),
        border: InputBorder.none,
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  final TextEditingController _passwordController;

  const PasswordField({Key? key, required TextEditingController controller})
      : _passwordController = controller,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      style: TextStyle(
        color: Color(
          0xFFCFCFCF,
        ),
      ),
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: Icon(
          Icons.lock,
          color: Color(0xFFCFCFCF),
        ),
        labelStyle: TextStyle(
          color: Color(0xFF8F8F8F),
        ),
        border: InputBorder.none,
      ),
    );
  }
}

class FieldsLayoutDelegate extends MultiChildLayoutDelegate {
  FieldsLayoutDelegate({this.position});
  final Offset? position;

  @override
  void performLayout(Size size) {
    Size? emailTextField, passwordTextField;
    if (hasChild('emailTextField')) {
      emailTextField = layoutChild(
        'emailTextField',
        BoxConstraints.tightFor(
          width: size.width,
        ),
      );
      positionChild(
        'emailTextField',
        Offset(
          size.width * 0.2,
          size.height * 0.4,
        ),
      );
    }
    if (hasChild('passwordTextField')) {
      passwordTextField = layoutChild(
        'passwordTextField',
        BoxConstraints.tightFor(
          width: size.width,
        ),
      );
      positionChild(
        'passwordTextField',
        Offset(
          size.width * 0.2,
          size.height * 0.65,
        ),
      );
    }
    if (hasChild('underline1')) {
      layoutChild('underline1', BoxConstraints());
      positionChild(
        'underline1',
        Offset(
          size.width * 0.17,
          emailTextField!.height + size.height * 0.4,
        ),
      );
    }
    if (hasChild('underline2')) {
      layoutChild('underline2', BoxConstraints());
      positionChild(
        'underline2',
        Offset(
          size.width * 0.17,
          passwordTextField!.height + size.height * 0.65,
        ),
      );
    }
  }

  @override
  bool shouldRelayout(covariant FieldsLayoutDelegate oldDelegate) {
    return oldDelegate.position != position;
  }
}
