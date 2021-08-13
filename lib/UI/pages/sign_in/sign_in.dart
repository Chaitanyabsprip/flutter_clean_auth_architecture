import '../../components/auth_buttons.dart';
import '../../components/onboarding_page_content.dart';
import '../../components/page_heading.dart';
import '../../components/utils.dart';
import '../home/home.dart';
import '../../../core/authentication/PLoC/sign_in_bloc.dart';
import '../../../core/authentication/PLoC/sign_in_events.dart';
import '../../../core/authentication/PLoC/sign_in_states.dart';
import '../../../core/authentication/domain/usecase/authentication_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          OnBoardingPageContent(),
          BlocProvider<SignInBloc>(
            create: (context) => SignInBloc(
              authenticationUsecase: GetIt.I.get<Authentication>(),
              initialState: SignInState.empty(),
            ),
            child: SignInOptions(),
          ),
        ],
      ),
    );
  }
}

class SignInOptions extends StatelessWidget {
  const SignInOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignInBloc _signBloc = BlocProvider.of<SignInBloc>(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SignInButton(
            label: "Google",
            onPressed: () async {
              print("attemting sign in");
              _signBloc.add(SignInWithGooglePressed());
              if (_signBloc.state.isSuccess) {
                pushPage(
                  context,
                  HomePage(),
                );
              }
              if (!_signBloc.state.isSuccess) print("google sign in failed");
            },
            icon: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                "assets/icons/google_logo.png",
                width: 28,
                height: 28,
              ),
            ),
          ),
          SignInButton(
            label: "Email",
            onPressed: () async {
              pushPage(
                context,
                SignInWithEmailPageContent(),
              );
            },
            icon: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                "assets/icons/Email.png",
                width: 28,
                height: 28,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SignInPageContent extends StatefulWidget {
  final PageController controller;
  SignInPageContent({Key? key, required this.controller}) : super(key: key);

  @override
  _SignInPageContentState createState() => _SignInPageContentState();
}

class _SignInPageContentState extends State<SignInPageContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      child: PageView(
        controller: widget.controller,
        children: <Widget>[
          Center(child: Text("Sign In")),
          Center(child: Text("Sign Up")),
        ],
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class SignInWithEmailPageContent extends StatelessWidget {
  SignInWithEmailPageContent({Key? key}) : super(key: key);
  final PageController _credentialFormPageController = PageController();

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: SignInWithEmailPageLayoutDelegate(),
      children: <Widget>[
        LayoutId(
          id: 'SignIn',
          child: TextButton(
            child: PageHeading(
              text: 'Sign In',
              fontSize: 60,
            ),
            onPressed: () {
              if (_credentialFormPageController.page == 1)
                _credentialFormPageController.jumpToPage(0);
            },
          ),
        ),
        LayoutId(
          id: 'SignUp',
          child: TextButton(
            child: PageHeading(
              text: 'Sign Up',
              fontSize: 30,
              color: Color(0x66CFCFCF),
            ),
            onPressed: () {
              if (_credentialFormPageController.page == 0)
                _credentialFormPageController.jumpToPage(1);
            },
          ),
        ),
        LayoutId(
          id: 'underline',
          child: Container(
            color: Color(0xFFFF89C2),
            width: MediaQuery.of(context).size.width * 0.83,
            height: 5,
          ),
        ),
        LayoutId(
          id: "with_email",
          child: SignInPageContent(
            controller: _credentialFormPageController,
          ),
        ),
      ],
    );
  }
}

class SignInWithEmailPageLayoutDelegate extends MultiChildLayoutDelegate {
  SignInWithEmailPageLayoutDelegate({this.position});

  final Offset? position;
  @override
  void performLayout(Size size) {
    Size signInTabSize = Size.zero,
        signUpTabSize = Size.zero,
        underlineSize = Size.zero;
    double topMargin = size.height * 0.25;

    if (hasChild('SignIn')) {
      signInTabSize = layoutChild(
        'SignIn',
        BoxConstraints(
          minWidth: size.width / 2,
          maxWidth: size.width / 2,
          minHeight: 96.0,
          maxHeight: 96.0,
        ),
      );
      positionChild(
        'SignIn',
        Offset(
          0,
          size.height * 0.25,
        ),
      );
    }

    if (hasChild('SignUp')) {
      signUpTabSize = layoutChild(
        'SignUp',
        BoxConstraints(
          minWidth: size.width / 2,
          maxWidth: size.width / 2,
          minHeight: 78.0,
          maxHeight: 96.0,
        ),
      );
      positionChild(
        'SignUp',
        Offset(
          signInTabSize.width,
          topMargin + signInTabSize.height - signUpTabSize.height,
        ),
      );
    }

    if (hasChild('underline')) {
      final underlineSize = layoutChild('underline', BoxConstraints());
      positionChild(
        'underline',
        Offset(
          size.width * 0.17,
          signInTabSize.height * 0.85 + topMargin,
        ),
      );
    }

    if (hasChild('with_email')) {
      final credentialFieldsSize = layoutChild(
        'with_email',
        BoxConstraints(
          maxHeight: size.height * 0.57,
          minHeight: 400.0,
          maxWidth: size.width,
        ),
      );
      positionChild(
        'with_email',
        Offset(
          (size.width - credentialFieldsSize.width) / 2,
          signInTabSize.height + topMargin + 16,
        ),
      );
    }
  }

  @override
  bool shouldRelayout(SignInWithEmailPageLayoutDelegate oldDelegate) {
    return oldDelegate.position != position;
  }
}
