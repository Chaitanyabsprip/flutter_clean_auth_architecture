import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:loggy/loggy.dart';

import '../../../error/exceptions.dart';
import '../../domain/entity/credentials.dart';
import '../../domain/entity/user.dart';
import '../models/user_model.dart';
import 'authentication_service.dart';

class AuthenticationDelegateImplementation
    with NetworkLoggy
    implements AuthenticationDelegate {
  final firebase.FirebaseAuth _authInstance;

  AuthenticationDelegateImplementation({
    required firebase.FirebaseAuth authInstance,
  }) : _authInstance = authInstance;

  @override
  Stream<UserModel> get authStateChanges =>
      _authInstance.authStateChanges().asyncMap(
            (firebase.User? user) => UserModel(
              email: Email(user!.email!),
              emailVerified: user.emailVerified,
              uid: user.uid,
              name: Name.fromString(user.displayName!),
            ),
          );

  @override
  Future<UserModel> get user async {
    loggy.info("Fetching user");
    final user = await _authInstance.authStateChanges().first;

    if (user == null) return NullUser();
    return UserModel(
      uid: user.uid,
      email: Email(user.email!),
      emailVerified: user.emailVerified,
    );
  }

  @override
  Future<void> deleteUser() async {
    loggy.info("Deleting user");
    try {
      await _authInstance.currentUser!.delete();
    } on firebase.FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        loggy.error(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    loggy.info("Forgot password request");
    try {
      await _authInstance.sendPasswordResetEmail(email: email);
    } on firebase.FirebaseAuthException catch (e, s) {
      loggy.debug(e, e, s);
      throw AuthException();
    }
  }

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
  }) async {
    loggy.info("Signing Up");
    try {
      firebase.UserCredential userCredential =
          await _authInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final _user = userCredential.user!;

      final UserModel userModel = UserModel(
        name: Name.fromString(_user.displayName ?? "Red Palidan"),
        email: Email(_user.email!),
        emailVerified: _user.emailVerified,
        uid: _user.uid,
      );
      return userModel;
    } on firebase.FirebaseAuthException catch (e, s) {
      if (e.code == 'weak-password') {
        loggy.info('The password provided is too weak.', e, s);
        throw InvalidCredentials(message: "Weak Password");
      } else if (e.code == 'email-already-in-use') {
        loggy.info('The account already exists for that email.', e, s);
        throw InvalidCredentials(message: "Email already in use");
      }
    } catch (e, s) {
      loggy.error(e, e, s);
      throw AuthException();
    }
    return NullUser();
  }
}
