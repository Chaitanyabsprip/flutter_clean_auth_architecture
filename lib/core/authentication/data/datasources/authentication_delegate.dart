import 'package:firebase_auth/firebase_auth.dart' as firebase;

import '../../domain/entity/credentials.dart';
import '../../domain/entity/user.dart';
import '../models/user_model.dart';
import 'authentication_service.dart';

class AuthenticationDelegateImplementation implements AuthenticationDelegate {
  final firebase.FirebaseAuth _authInstance;

  AuthenticationDelegateImplementation(
      {required firebase.FirebaseAuth authInstance})
      : _authInstance = authInstance;

  @override
  Future<void> deleteUser() async {
    try {
      await _authInstance.currentUser!.delete();
    } on firebase.FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  @override
  UserModel get user {
    final user = _authInstance.currentUser;

    if (user == null) return NullUser();
    return UserModel(
      name: Name.fromString(user.displayName!),
      uid: user.uid,
      email: Email(user.email!),
      emailVerified: user.emailVerified,
    );
  }

  @override
  Future<void> forgotPassword({required String email}) {
    return _authInstance.sendPasswordResetEmail(email: email);
  }

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
  }) async {
    try {
      firebase.UserCredential userCredential =
          await _authInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user!;

      return UserModel(
        name: Name.fromString(user.displayName!),
        email: Email(user.email!),
        emailVerified: user.emailVerified,
        uid: user.uid,
      );
    } on firebase.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return NullUser();
  }
}
