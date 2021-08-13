import '../../domain/entity/credentials.dart';

import '../../domain/entity/user.dart';
import '../../domain/repository/authentication_repository.dart';
import '../datasources/authentication_service.dart';
import '../models/user_model.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  late AuthenticationService _authService;
  final AuthenticationDelegate _authDelegate;

  AuthenticationRepositoryImplementation({
    required AuthenticationDelegate authDelegate,
  }) : _authDelegate = authDelegate;

  @override
  set authMethod(AuthenticationService authService) =>
      _authService = authService;

  @override
  Future<void> forgotPassword({required Email email}) async =>
      await _authDelegate.forgotPassword(email: email.value);

  @override
  Stream<User> authState() =>
      Stream.castFrom<UserModel, User>(_authService.authState);

  @override
  Future<User> currentUser() async => _authDelegate.user;

  @override
  Future<User> signInWithEmail({
    required Email email,
    required Password password,
  }) async =>
      _authService.signIn();

  @override
  Future<User> signInWithGoogle() async {
    return await _authService.signIn();
  }

  @override
  Future<void> signOut() async => _authService.signOut();

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
