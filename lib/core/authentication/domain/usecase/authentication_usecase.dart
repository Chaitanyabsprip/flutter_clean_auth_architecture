import '../../data/datasources/authentication_service.dart';
import '../entity/credentials.dart';
import '../entity/user.dart';
import '../repository/authentication_repository.dart';

abstract class Authentication {
  Future<void> forgotPassword({required String email});
  Stream<User> getAuthState();
  Future<User> getCurrentUser();
  Future<User> signIn({required AuthenticationService authenticationService});
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
  // TODO : How to handle error for a function with void return type
  Future<void> forgotPassword({required String email}) async =>
      await _authRepository.forgotPassword(email: Email(email));

  @override
  Stream<User> getAuthState() async* {
    yield* _authRepository.authState();
  }

  @override
  Future<User> getCurrentUser() async => await _authRepository.currentUser();

  @override
  Future<User> signIn({
    required AuthenticationService authenticationService,
  }) async {
    final User user = await _authRepository.signIn(
        authenticationService: authenticationService);
    return user;
  }

  @override
  Future<void> signOut() async => await _authRepository.signOut();

  @override
  Future<User> signUp({
    required String email,
    required String password,
  }) async {
    User user;
    user = await _authRepository.signUp(
      email: Email(email),
      password: Password(password),
    );
    return user;
  }
}
