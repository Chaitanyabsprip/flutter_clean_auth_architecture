import '../entity/credentials.dart';

import '../../data/datasources/authentication_service.dart';
import '../entity/user.dart';

abstract class AuthenticationRepository {
  set authMethod(AuthenticationService authService);
  Future<User> currentUser();
  Future<User> signInWithEmail({
    required Email email,
    required Password password,
  });
  Future<User> signInWithGoogle();
  Future<User> signUp({
    required Email email,
    required Password password,
  });
  Future<void> forgotPassword({required Email email});
  Future<void> signOut();
  Stream<User> authState();
}
