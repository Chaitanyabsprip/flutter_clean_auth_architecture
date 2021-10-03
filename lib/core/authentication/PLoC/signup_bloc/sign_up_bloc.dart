import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:loggy/loggy.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entity/credentials.dart';
import '../../domain/usecase/authentication_usecase.dart';
import 'sign_up_events.dart';
import 'sign_up_states.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> with UiLoggy {
  Authentication _auth;

  SignUpBloc({
    required SignUpState initialState,
    required Authentication authenticationUsecase,
  })  : _auth = authenticationUsecase,
        super(initialState);

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpEmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is SignUpPasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is ConfirmPasswordChanged) {
      yield* _mapConfirmPasswordChangedToState(
        event.password,
        event.confirmPassword,
      );
    } else if (event is SignUpButtonPressed) {
      yield* _mapSignUpButtonPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  @override
  void onChange(Change<SignUpState> change) {
    loggy.debug(change);
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    loggy.error('$error \n $stackTrace');
    super.onError(error, stackTrace);
  }

  @override
  Stream<Transition<SignUpEvent, SignUpState>> transformEvents(
      Stream<SignUpEvent> events,
      TransitionFunction<SignUpEvent, SignUpState> next) {
    final nonDebounceStream = events.where(
      (event) =>
          (event is! SignUpEmailChanged && event is! SignUpPasswordChanged),
    );
    final debounceStream = events
        .where(
          (event) =>
              (event is SignUpEmailChanged || event is SignUpPasswordChanged),
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

  Stream<SignUpState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Email.validate(email),
    );
  }

  Stream<SignUpState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Password.validate(password),
    );
  }

  Stream<SignUpState> _mapSignUpButtonPressedToState({
    required String email,
    required String password,
  }) async* {
    yield SignUpLoading();
    try {
      final user = await _auth.signUp(
        email: email,
        password: password,
      );
      yield SignUpSuccess(user: user);
    } catch (e) {
      loggy.error(e);
      yield SignUpFailure();
    }
  }

  Stream<SignUpState> _mapConfirmPasswordChangedToState(
    String password,
    String confirmPassword,
  ) async* {
    yield state.update(
      confirmPasswordMatches: password == confirmPassword,
    );
  }
}
