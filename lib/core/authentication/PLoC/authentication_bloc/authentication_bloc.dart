import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loggy/loggy.dart';

import '../../data/models/user_model.dart';
import '../../domain/entity/user.dart';
import '../../domain/usecase/authentication_usecase.dart';
import 'authentication_events.dart';
import 'authentication_states.dart';

const SOMETHING_WENT_WRONG = "Something went wrong.";
const NO_INTERNET_CONNECTION_MESSAGE = "You're offline";
const SIGN_OUT_FAILURE_MESSAGE = "Failed to Sign Out";
const WRONG_CREDENTIAL_FAILURE =
    "The email or the password entered was incorrect";

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>
    with UiLoggy {
  final Authentication _authentication;

  AuthenticationBloc({
    required AuthenticationState initialState,
    required Authentication auth,
  })  : _authentication = auth,
        super(initialState);

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  @override
  void onChange(Change<AuthenticationState> change) {
    loggy.debug(change);
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    loggy.error('$error \n $stackTrace');
    super.onError(error, stackTrace);
  }

  Stream<AuthenticationState> _initStartup() async* {}

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final user = await _authentication.getCurrentUser();
      loggy.info(user.toString());
      if (user != NullUser() && user is User) {
        loggy.info("Authenticated");
        yield Authenticated(user: user);
      } else {
        loggy.info("Not Authenticated.");
        yield UnAuthenticated();
      }
    } catch (_) {
      loggy.info("Not Authenticated.");
      loggy.warning("Exception Raised in fetching authentication status.");
      yield UnAuthenticated();
    }
    yield* _initStartup();
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    try {
      final currentUser = await _authentication.getCurrentUser();
      if (currentUser is! NullUser) {
        yield Authenticated(user: currentUser);
        return;
      }
    } catch (e) {
      print(e);
      yield AuthenticationError(message: SOMETHING_WENT_WRONG);
      yield UnAuthenticated();
      return;
    }
    yield AuthenticationError(message: WRONG_CREDENTIAL_FAILURE);
    yield UnAuthenticated();
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    User currentUser = NullUser();
    try {
      await _authentication.signOut();
      currentUser = await _authentication.getCurrentUser();
      assert(currentUser is NullUser);
    } catch (e, s) {
      loggy.error(e, e, s);
      yield AuthenticationError(message: SIGN_OUT_FAILURE_MESSAGE);
    }
    yield UnAuthenticated();
  }
}
