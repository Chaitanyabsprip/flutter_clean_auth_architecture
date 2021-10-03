import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:loggy/loggy.dart';

import '../../../error/exceptions.dart';
import '../../domain/entity/credentials.dart';
import '../models/user_model.dart';
import 'authentication_service.dart';

class EmailAuthentication with NetworkLoggy implements AuthenticationService {
  final Email email;
  final Password password;
  final firebase.FirebaseAuth _authInstance;

  EmailAuthentication({
    required this.email,
    required this.password,
    required firebase.FirebaseAuth authInstance,
  }) : _authInstance = authInstance;

  @override
  Future<UserModel> signIn() async {
    loggy.info("Signing In.");
    try {
      firebase.UserCredential userCredential =
          await _authInstance.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      final user = userCredential.user!;
      if (!user.emailVerified) await user.sendEmailVerification();

      final userModel = UserModel(
        email: Email(user.email!),
        emailVerified: user.emailVerified,
        uid: user.uid,
      );

      return userModel;
    } on firebase.FirebaseAuthException catch (e, s) {
      if (e.code == 'user-not-found') {
        loggy.warning('No user found for that email.', e, s);
        throw InvalidCredentials(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        loggy.warning('Incorrect Password', e, s);
        throw InvalidCredentials(message: 'Incorrect Password');
      } else if (e.code == 'account-exists-with-different-credential') {
        loggy.warning(
            'Account already exists with a different credential', e, s);
        throw InvalidCredentials(
            message: 'Account already exists with a different credential');
      }
      loggy.warning(e, e, s);
    } catch (e, s) {
      loggy.error(e, e, s);
    }
    return NullUser();
  }

  @override
  Future<void> signOut() async {
    loggy.info("Signing Out");
    await _authInstance.signOut();
  }
}
