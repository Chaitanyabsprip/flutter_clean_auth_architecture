import '../../domain/entity/credentials.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/entity/user.dart';
import '../models/user_model.dart';
import 'authentication_service.dart';

class GoogleAuthentication implements AuthenticationService {
  final firebase.FirebaseAuth _authInstance;
  UserModel _user = NullUser();

  GoogleAuthentication({required firebase.FirebaseAuth authInstance})
      : _authInstance = authInstance;

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
  Future<UserModel> signIn() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = firebase.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    final user = (await _authInstance.signInWithCredential(credential)).user;

    return UserModel(
        email: Email(user!.email!),
        emailVerified: user.emailVerified,
        uid: user.uid,
        name: Name.fromString(user.displayName!));
  }

  @override
  Future<void> signOut() async {
    await _authInstance.signOut();
    await GoogleSignIn().signOut();
    _user = NullUser();
  }
}
