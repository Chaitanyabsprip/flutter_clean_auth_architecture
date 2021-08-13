import 'package:get_it/get_it.dart';

import '../../../error/exceptions.dart';
import '../../data/datasources/authentication_service.dart';
import '../../data/datasources/email_authentication.dart';
import '../../data/datasources/google_authentication.dart';
import '../../data/models/user_model.dart';
import '../entity/credentials.dart';
import '../entity/user.dart';
import '../repository/authentication_repository.dart';

abstract class Authentication {
  set authMethod(AuthenticationService authService);
  Future<void> forgotPassword({required String email});
  Stream<User> getAuthState();
  Future<User> getCurrentUser();
  Future<User> signInWithEmail({
    required String email,
    required String password,
  });
  Future<User> signInWithGoogle();
  Future<void> signOut();
  Future<User> signUp({
    required String email,
    required String password,
  });
}

class AuthenticationUsecase implements Authentication {
  final AuthenticationRepository _authRepository;

  AuthenticationUsecase({
    required AuthenticationRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  set authMethod(AuthenticationService authService) {
    // TODO : How can I test this
    _authRepository.authMethod = authService;
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await _authRepository.forgotPassword(email: Email(email));
    } on InvalidCredentials catch (_) {
      // TODO : How to handle error for a function with void return type
    }
  }

  @override
  Stream<User> getAuthState() async* {
    yield* _authRepository.authState();
  }

  @override
  Future<User> getCurrentUser() async => await _authRepository.currentUser();

  @override
  Future<User> signInWithEmail({
    required String email,
    required String password,
  }) async {
    User user;
    final userEmail = Email(email);
    final userPassword = Password(password);

    try {
      //TODO : how to get around dependency injection for testing
      _authRepository.authMethod = GetIt.I.get<EmailAuthentication>(
        param1: userEmail,
        param2: userPassword,
      );
      user = await _authRepository.signInWithEmail(
        email: userEmail,
        password: userPassword,
      );
    } on InvalidCredentials catch (_) {
      user = NullUser();
    }

    return user;
  }

  @override
  Future<User> signInWithGoogle() async {
    //TODO : how to get around dependency injection for testing
    _authRepository.authMethod = GetIt.I.get<GoogleAuthentication>();
    print(_authRepository);
    return await _authRepository.signInWithGoogle();
  }

  @override
  Future<void> signOut() async => await _authRepository.signOut();

  @override
  Future<User> signUp({
    required String email,
    required String password,
  }) async {
    User user;

    try {
      user = await _authRepository.signUp(
        email: Email(email),
        password: Password(password),
      );
    } on InvalidCredentials catch (_) {
      user = NullUser();
    }

    return user;
  }
}
