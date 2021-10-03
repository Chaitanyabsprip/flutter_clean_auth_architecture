import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loggy/loggy.dart';

import '../../../error/exceptions.dart';
import '../../domain/entity/credentials.dart';
import '../../domain/entity/user.dart';
import '../models/user_model.dart';
import 'authentication_service.dart';

class GoogleAuthentication with NetworkLoggy implements AuthenticationService {
  final firebase.FirebaseAuth _authInstance;
  final SocialCredentials _googleCredentials;

  GoogleAuthentication({
    required firebase.FirebaseAuth authInstance,
    required SocialCredentials googleCredentials,
  })  : _authInstance = authInstance,
        _googleCredentials = googleCredentials;

  @override
  Future<UserModel> signIn() async {
    loggy.info("Signing In.");
    late final UserModel userModel;
    try {
      firebase.OAuthCredential credential = await _googleCredentials();
      final user = (await _authInstance.signInWithCredential(credential)).user;
      userModel = UserModel(
          email: Email(user!.email!),
          emailVerified: user.emailVerified,
          uid: user.uid,
          name: Name.fromString(user.displayName!));
    } on firebase.FirebaseAuthException catch (e, s) {
      loggy.error("FirebaseAuthException occured", e, s);
      throw AuthException();
    } catch (e, s) {
      loggy.error(e, e, s);
      throw AuthException();
    }
    return userModel;
  }

  @override
  Future<void> signOut() async {
    loggy.info("Signing Out");
    await _authInstance.signOut();
    await _googleCredentials.signOut();
  }
}

class GoogleCredentials implements SocialCredentials {
  @override
  Future<fb.OAuthCredential> call() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = firebase.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return credential;
  }

  @override
  Future<void> signOut() async {
    await GoogleSignIn().signOut();
  }
}
