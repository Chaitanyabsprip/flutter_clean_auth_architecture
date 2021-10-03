import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'UI/components/entry_delegate.dart';
import 'core/authentication/PLoC/authentication_bloc/authentication_bloc.dart';
import 'core/authentication/PLoC/authentication_bloc/authentication_states.dart';
import 'core/authentication/domain/usecase/authentication_usecase.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();
  runApp(FlutterCleanAuthArchitecture());
}

class FlutterCleanAuthArchitecture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) => AuthenticationBloc(
          initialState: UnInitialized(),
          auth: GetIt.I.get<Authentication>(),
        ),
        child: EntryDelegate(),
      ),
    );
  }
}
