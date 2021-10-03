import '../../../error/exceptions.dart';
import '../models/user_model.dart';
import 'authentication_service.dart';

class NullAuthenticationService implements AuthenticationService {
  @override
  Future<UserModel> signIn() {
    throw AuthException();
  }

  @override
  Future<void> signOut() {
    throw AuthException();
  }
}
