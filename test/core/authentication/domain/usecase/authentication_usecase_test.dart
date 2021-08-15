import 'package:flutter_clean_auth_architecture/core/authentication/domain/entity/credentials.dart';
import 'package:flutter_clean_auth_architecture/core/authentication/domain/entity/user.dart';
import 'package:flutter_clean_auth_architecture/core/authentication/domain/repository/authentication_repository.dart';
import 'package:flutter_clean_auth_architecture/core/authentication/domain/usecase/authentication_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockAuthenticationRepository repository;
  late Authentication usecase;
  late User user;
  final tEmail = Email("chitanyasharma@gmail.com");
  final tPassword = Password("PO.tree24");

  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = AuthenticationUsecase(authRepository: repository);
    user = User(
      age: 22,
      email: tEmail,
      emailVerified: true,
      name: Name.fromString("Chaitanya Sharma"),
      uid: "UniqueID",
    );

    when(() => repository.forgotPassword(email: tEmail))
        .thenAnswer((_) => Future.value());
    when(() => repository.signOut()).thenAnswer((_) => Future.value());
  });

  test("should call repository.forgotPassword() when called on usecase",
      () async {
    await usecase.forgotPassword(email: tEmail.value);
    verify(() => repository.forgotPassword(email: tEmail));
    verifyNoMoreInteractions(repository);
  });

  test("should call repository.signOut() when called on usecase", () async {
    await usecase.signOut();
    verify(() => repository.signOut());
    verifyNoMoreInteractions(repository);
  });

  test("should call respository.authState() when call on usecase", () async {
    when(() => repository.authState()).thenAnswer((_) async* {
      yield user;
    });

    expect(usecase.getAuthState(), emits(user));
    // verify(() => repository.authState());
    verifyNoMoreInteractions(repository);
  });

  test("should get currentUser", () async {
    when(() => repository.currentUser()).thenAnswer((_) async => user);

    expect(await usecase.getCurrentUser(), user);
    verify(() => repository.currentUser());
  });

  test("should sign in with email", () async {
    when(() => repository.signInWithEmail(
          email: tEmail,
          password: tPassword,
        )).thenAnswer((_) async => user);

    expect(
      await usecase.signInWithEmail(
        email: tEmail.value,
        password: tPassword.value,
      ),
      user,
    );
  });
}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}
