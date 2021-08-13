import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/user_model.dart';
import '../domain/usecase/authentication_usecase.dart';
import 'authentication_events.dart';
import 'authentication_states.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Authentication _authRepository;

  AuthenticationBloc({
    required AuthenticationState initialState,
    required Authentication auth,
  })  : _authRepository = auth,
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
    print(change);
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error \n $stackTrace');
    super.onError(error, stackTrace);
  }

  Stream<AuthenticationState> _initStartup() async* {}

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final user = await _authRepository.getCurrentUser();
      if (user != NullUser()) {
        yield Authenticated(user: user);
      } else
        yield UnAuthenticated();
    } catch (_) {
      yield UnAuthenticated();
    }

    yield* _initStartup();
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(user: await _authRepository.getCurrentUser());
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield UnAuthenticated();
    _authRepository.signOut();
  }
}
