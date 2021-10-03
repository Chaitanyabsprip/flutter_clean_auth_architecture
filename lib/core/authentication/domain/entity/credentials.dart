import '../../../error/exceptions.dart';
import 'package:equatable/equatable.dart';

class Email extends Equatable {
  final String _value;

  factory Email(String email) {
    if (validate(email)) {
      return Email._(email);
    } else {
      throw InvalidCredentials();
    }
  }

  static bool validate(String email) {
    const emailRegex =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    var hasMatch = RegExp(emailRegex).hasMatch(email);
    return hasMatch;
  }

  Email._(String value) : _value = value;

  String get value => _value;

  @override
  List<Object?> get props => [_value];

  @override
  bool get stringify => true;
}

class Password extends Equatable {
  final String _value;

  factory Password(String password) {
    if (validate(password) && password.length >= 8) {
      return Password._(password);
    } else {
      throw InvalidCredentials();
    }
  }

  Password._(String value) : _value = value;

  static bool validate(String password) {
    const passwordRegex =
        r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{8,}$";
    return RegExp(passwordRegex).hasMatch(password);
  }

  String get value => _value;

  @override
  List<Object?> get props => [_value];

  @override
  bool get stringify => true;
}
