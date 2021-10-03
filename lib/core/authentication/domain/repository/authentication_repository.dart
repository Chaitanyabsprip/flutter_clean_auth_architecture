import '../../data/datasources/authentication_service.dart';
import '../entity/credentials.dart';
import '../entity/user.dart';

abstract class AuthenticationRepository {
  Future<User> currentUser();
  Future<User> signIn({required AuthenticationService authenticationService});
  Future<User> signUp({
    required Email email,
    required Password password,
  });
  Future<void> forgotPassword({required Email email});
  Future<void> signOut();
  Stream<User> authState();
}
