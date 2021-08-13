import 'core/authentication/domain/usecase/authentication_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'core/authentication/data/datasources/authentication_delegate.dart';
import 'core/authentication/data/datasources/authentication_service.dart';
import 'core/authentication/data/datasources/email_authentication.dart';
import 'core/authentication/data/datasources/google_authentication.dart';
import 'core/authentication/data/repository/authentication_repository_implementation.dart';
import 'core/authentication/domain/entity/credentials.dart';
import 'core/authentication/domain/repository/authentication_repository.dart';

Future<void> setupLocator() async {
  slAuthInit();
}

void slAuthInit() {
  // Authentication
  GetIt.I.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  GetIt.I.registerFactory<GoogleAuthentication>(
    () => GoogleAuthentication(
      authInstance: GetIt.I.get<FirebaseAuth>(),
    ),
  );
  GetIt.I.registerFactoryParam<EmailAuthentication, Email, Password>(
    (
      Email email,
      Password password,
    ) {
      return EmailAuthentication(
        email: email,
        password: password,
        authInstance: GetIt.I.get<FirebaseAuth>(),
      );
    },
  );
  GetIt.I.registerSingleton<AuthenticationDelegate>(
    AuthenticationDelegateImplementation(
      authInstance: GetIt.I.get<FirebaseAuth>(),
    ),
  );
  GetIt.I.registerSingleton<AuthenticationRepository>(
    AuthenticationRepositoryImplementation(
      authDelegate: GetIt.I.get<AuthenticationDelegate>(),
    ),
  );
  GetIt.I.registerSingleton<Authentication>(
    AuthenticationUsecase(
      authRepository: GetIt.I.get<AuthenticationRepository>(),
    ),
  );
}
