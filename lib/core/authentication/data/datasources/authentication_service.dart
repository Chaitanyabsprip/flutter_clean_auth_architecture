// TODO: (1) reauthenticating the user. (2) linking different providers with same email as one.
import '../models/user_model.dart';

abstract class AuthenticationService {
  Stream<UserModel> get authState;
  Future<UserModel> signIn();
  Future<void> signOut();
}

abstract class AuthenticationDelegate {
  Future<UserModel> signUp({
    required String email,
    required String password,
  });
  Future<void> deleteUser();
  Future<void> forgotPassword({required String email});
  UserModel get user;
}
