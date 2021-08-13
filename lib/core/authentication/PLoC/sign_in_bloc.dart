import 'dart:async';

import 'package:bloc/bloc.dart';
import '../data/datasources/email_authentication.dart';
import '../domain/entity/credentials.dart';
import '../domain/usecase/authentication_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

import 'sign_in_events.dart';
import 'sign_in_states.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  Authentication _auth;

  SignInBloc({
    required SignInState initialState,
    required Authentication authenticationUsecase,
  })  : _auth = authenticationUsecase,
        super(initialState);

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is SignInWithGooglePressed) {
      yield* _mapSignInWithGooglePressedToState();
    } else if (event is SignInWithCredentialsPressed) {
      yield* _mapSignInWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  @override
  void onChange(Change<SignInState> change) {
    print(change);
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error \n $stackTrace');
    super.onError(error, stackTrace);
  }

  @override
  Stream<Transition<SignInEvent, SignInState>> transformEvents(
      Stream<SignInEvent> events,
      TransitionFunction<SignInEvent, SignInState> next) {
    // final observableStream = events as Observable<SignInEvent>;
    final nonDebounceStream = events.where(
      (event) => (event is! EmailChanged && event is! PasswordChanged),
    );
    final debounceStream = events
        .where(
          (event) => (event is EmailChanged || event is PasswordChanged),
        )
        .debounce(
          (event) => TimerStream(
            true,
            Duration(milliseconds: 300),
          ),
        );
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  Stream<SignInState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Email.validate(email),
    );
  }

  Stream<SignInState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Password.validate(password),
    );
  }

  Stream<SignInState> _mapSignInWithCredentialsPressedToState({
    required String email,
    required String password,
  }) async* {
    yield SignInState.loading();
    _auth.authMethod = GetIt.I.get<EmailAuthentication>(
      param1: email,
      param2: password,
    );
    try {
      await _auth.signInWithEmail(
        email: email,
        password: password,
      );
      yield SignInState.success();
    } catch (e) {
      print(e);
      yield SignInState.failure();
    }
  }

  Stream<SignInState> _mapSignInWithGooglePressedToState() async* {
    try {
      await _auth.signInWithGoogle();
      yield SignInState.success();
    } catch (e) {
      print(e);
      yield SignInState.failure();
    }
  }
}
