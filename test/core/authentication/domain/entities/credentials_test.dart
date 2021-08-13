import 'package:crimson/core/authentication/domain/entity/credentials.dart';
import 'package:crimson/core/error/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Email email;
  late Password password;

  group(
    "Email",
    () {
      final tEmail = "chaitanyasanjeevsharma@gmail.com";
      final tInvalidEmail = "asdasd";
      email = Email(tEmail);

      setUp(() {
        email = Email(tEmail);
      });

      test("should throw an Exception for invalid email", () {
        expect(
          () => Email(tInvalidEmail),
          throwsA(TypeMatcher<InvalidCredentials>()),
        );
      });

      test("should not throw an exception for valid email", () {
        expect(() => Email(tEmail), returnsNormally);
      });

      test("should validate email", () {
        expect(Email.validate(tEmail), true);
        expect(Email.validate(tInvalidEmail), false);
      });

      test("should return email as String", () {
        expect(email.value, tEmail);
        expect(email.value, isA<String>());
      });
    },
  );

  group("Password", () {
    final tPassword = "PO.tree24";
    final tInvalidPassword = "a\\sdasd";
    password = Password(tPassword);

    setUp(() {
      password = Password(tPassword);
    });

    test("should throw an Exception for invalid password", () {
      expect(
        () => Password(tInvalidPassword),
        throwsA(TypeMatcher<InvalidCredentials>()),
      );
    });

    test("should not throw an exception for valid password", () {
      expect(() => Password(tPassword), returnsNormally);
    });

    test("should validate password", () {
      expect(Password.validate(tPassword), true);
      expect(Password.validate(tInvalidPassword), false);
    });

    test("should return password as String", () {
      expect(password.value, tPassword);
      expect(password.value, isA<String>());
    });
  });
}
