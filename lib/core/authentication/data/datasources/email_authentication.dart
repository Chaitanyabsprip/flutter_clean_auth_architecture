import '../../domain/entity/credentials.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

import '../../domain/entity/user.dart';
import '../models/user_model.dart';
import 'authentication_service.dart';

class EmailAuthentication implements AuthenticationService {
  final Email email;
  final Password password;
  final firebase.FirebaseAuth _authInstance;

  EmailAuthentication({
    required this.email,
    required this.password,
    required firebase.FirebaseAuth authInstance,
  }) : _authInstance = authInstance;

  @override
  Stream<UserModel> get authState => _authInstance.authStateChanges().asyncMap(
        (firebase.User? user) => UserModel(
          email: Email(user!.email!),
          emailVerified: user.emailVerified,
          uid: user.uid,
          name: Name.fromString(user.displayName!),
        ),
      );

  @override
  Future<UserModel> signIn() async {
    try {
      firebase.UserCredential userCredential =
          await _authInstance.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      final user = userCredential.user!;
      if (!user.emailVerified) await user.sendEmailVerification();

      return UserModel(
        name: Name.fromString(user.displayName!),
        email: Email(user.email!),
        emailVerified: user.emailVerified,
        uid: user.uid,
      );
    }
    // on firebase.FirebaseAuthException catch (e) {
    //   if (e.code == 'user-not-found') {
    //     print('No user found for that email.');
    //   } else if (e.code == 'wrong-password') {
    //     print('Incorrect Password');
    //   }
    // }
    catch (e) {
      print(e);
    }

    return NullUser();
  }

  @override
  Future<void> signOut() async {
    await _authInstance.signOut();
  }
}
