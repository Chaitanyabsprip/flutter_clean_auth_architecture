import '../pages/sign_in/login.dart';
import '../pages/sign_in/sign_in.dart';

import 'splash_screen.dart';
import '../pages/home/home.dart';
import '../../core/authentication/PLoC/authentication_bloc.dart';
import '../../core/authentication/PLoC/authentication_events.dart';
import '../../core/authentication/PLoC/authentication_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntryDelegate extends StatefulWidget {
  EntryDelegate({Key? key}) : super(key: key);

  @override
  _EntryDelegateState createState() => _EntryDelegateState();
}

class _EntryDelegateState extends State<EntryDelegate> {
  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    Future.delayed(
      Duration(seconds: 1),
      () async => _authenticationBloc.add(AppStarted()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      bloc: _authenticationBloc,
      builder: (context, state) {
        if (state is UnInitialized)
          return SplashScreen();
        else if (state is UnAuthenticated)
          return SignInPage();
        else if (state is Authenticated) return HomePage();

        return SplashScreen();
      },
    );
  }

  @override
  void dispose() {
    _authenticationBloc.close();
    super.dispose();
  }
}
