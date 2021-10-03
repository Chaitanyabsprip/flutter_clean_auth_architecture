import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loggy/loggy.dart';
import 'package:rxdart/rxdart.dart';

import '../../../error/exceptions.dart';
import '../../data/datasources/email_authentication.dart';
import '../../data/datasources/google_authentication.dart';
import '../../data/models/user_model.dart';
import '../../domain/entity/credentials.dart';
import '../../domain/usecase/authentication_usecase.dart';
import 'sign_in_events.dart';
import 'sign_in_states.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> with UiLoggy {
  Authentication _auth;

  SignInBloc({
    required SignInState initialState,
    required Authentication authenticationUsecase,
  })  : _auth = authenticationUsecase,
        super(initialState);

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignInEmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is SignInPasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is SignInWithGooglePressed) {
      yield* _mapSignInWithGooglePressedToState();
    } else if (event is SignInWithCredentialsPressed) {
      yield* _mapSignInWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    } else if (event is ForgotPasswordButtonPressed) {
      yield* _mapForgotPasswordButtonPressedToState(email: event.email);
    }
  }

  @override
  void onChange(Change<SignInState> change) {
    loggy.debug(change);
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    loggy.error('$error \n $stackTrace');
    super.onError(error, stackTrace);
  }

  @override
  Stream<Transition<SignInEvent, SignInState>> transformEvents(
      Stream<SignInEvent> events,
      TransitionFunction<SignInEvent, SignInState> next) {
    final nonDebounceStream = events.where(
      (event) =>
          (event is! SignInEmailChanged && event is! SignInPasswordChanged),
    );
    final debounceStream = events
        .where(
          (event) =>
              (event is SignInEmailChanged || event is SignInPasswordChanged),
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
    yield SignInState.from(state.copyWith(isEmailValid: true));
  }

  Stream<SignInState> _mapForgotPasswordButtonPressedToState({
    required String email,
  }) async* {
    try {
      await _auth.forgotPassword(email: email);
      yield SignInEmpty();
      return;
    } on InvalidCredentials catch (e, s) {
      loggy.error(e.message, e, s);
      yield SignInError(message: e.message); // TODO: concrete error handling
      return;
    } catch (e, s) {
      loggy.error(e, e, s);
      yield SignInError(message: e.toString()); // TODO: concrete error handling
      return;
    }
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
    yield SignInLoading();
    late final user;
    try {
      user = await _auth.signIn(
          authenticationService: GetIt.I.get<EmailAuthentication>());
      if (user is! NullUser) {
        yield SignInSuccess(user: user);
        return;
      }
    } on InvalidCredentials catch (e, s) {
      loggy.error(e.message, e, s);
      yield SignInError(message: e.message); // TODO: concrete error handling
      yield SignInFailure(message: "Something went wrong");
      return;
    } catch (e, s) {
      loggy.error(e, e, s);
      yield SignInError(message: e.toString()); // TODO: concrete error handling
      yield SignInFailure(message: "Something went wrong");
      return;
    }
    yield SignInFailure(message: "Sign in Failed.");
  }

  Stream<SignInState> _mapSignInWithGooglePressedToState() async* {
    try {
      final user = await _auth.signIn(
          authenticationService: GetIt.I.get<GoogleAuthentication>());
      if (user is! NullUser) {
        yield SignInSuccess(user: user);
        loggy.info("succesfully signed in with user: $user");
        return;
      }
    } catch (e, s) {
      loggy.error(e, e, s);
      yield SignInError(message: e.toString()); // TODO: concrete error handling
      yield SignInFailure(message: "Something went wrong");
      return;
    }
    yield SignInFailure(message: "Something went wrong");
  }
}
