import '../../core/authentication/PLoC/UI/pages/signin.dart';
import '../../core/authentication/PLoC/authentication_bloc/authentication_bloc.dart';
import '../../core/authentication/PLoC/authentication_bloc/authentication_events.dart';
import '../../core/authentication/PLoC/authentication_bloc/authentication_states.dart';
import '../../core/authentication/PLoC/signin_bloc/sign_in_bloc.dart';
import '../../core/authentication/PLoC/signin_bloc/sign_in_states.dart';
import '../../core/authentication/PLoC/signup_bloc/sign_up_bloc.dart';
import '../../core/authentication/PLoC/signup_bloc/sign_up_states.dart';
import '../../core/authentication/domain/usecase/authentication_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../pages/home/home.dart';
import '../pages/splash_screen.dart';

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
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) => SignInBloc(
                  initialState: SignInEmpty(),
                  authenticationUsecase: GetIt.I.get<Authentication>(),
                ),
              ),
              BlocProvider(
                create: (BuildContext context) => SignUpBloc(
                  initialState: SignUpEmpty(),
                  authenticationUsecase: GetIt.I.get<Authentication>(),
                ),
              ),
            ],
            child: SignIn(),
          );
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
