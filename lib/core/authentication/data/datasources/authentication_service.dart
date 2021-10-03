// TODO: (1) reauthenticating the user. (2) linking different providers with same email as one.
import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

abstract class AuthenticationService {
  /// Asynchronously signs in to Authentication Service
  /// If successful, it also signs the user in into the app and updates
  /// any [authStateChanges] stream listeners.
  Future<UserModel> signIn();

  /// Signs out the current user.
  /// If successful, it also updates
  /// any [authStateChanges] stream listeners.
  Future<void> signOut();
}

abstract class AuthenticationDelegate {
  /// Notifies about changes to the user's sign-in state (such as sign-in or
  /// sign-out).
  Stream<UserModel> get authStateChanges;

  Future<UserModel> signUp({
    required String email,
    required String password,
  });
  Future<void> deleteUser();
  Future<void> forgotPassword({required String email});
  Future<UserModel> get user;
}

abstract class SocialCredentials {
  Future<fb.OAuthCredential> call();
  Future<void> signOut();
}
