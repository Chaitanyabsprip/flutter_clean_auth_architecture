import '../../domain/entity/credentials.dart';
import '../../domain/entity/user.dart';
import '../../domain/repository/authentication_repository.dart';
import '../datasources/authentication_service.dart';
import '../datasources/null_authentication_service.dart';
import '../models/user_model.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  AuthenticationService _authService = NullAuthenticationService();
  final AuthenticationDelegate _authDelegate;

  AuthenticationRepositoryImplementation({
    required AuthenticationDelegate authDelegate,
  }) : _authDelegate = authDelegate;

  @override
  Future<void> forgotPassword({required Email email}) async =>
      await _authDelegate.forgotPassword(email: email.value);

  @override
  Stream<User> authState() =>
      Stream.castFrom<UserModel, User>(_authDelegate.authStateChanges);

  @override
  Future<User> currentUser() async => await _authDelegate.user;

  @override
  Future<User> signIn({required AuthenticationService authenticationService}) {
    _authService = authenticationService;
    return _authService.signIn();
  }

  @override
  Future<void> signOut() async {
    return _authService.signOut(); // distinguish no service chosen
  }

  @override
  Future<User> signUp({
    required Email email,
    required Password password,
  }) async {
    return await _authDelegate.signUp(
      email: email.value,
      password: password.value,
    );
  }
}
