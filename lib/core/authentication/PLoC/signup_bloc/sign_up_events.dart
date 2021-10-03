import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpEmailChanged extends SignUpEvent {
  final String email;

  SignUpEmailChanged(this.email);

  @override
  List<Object?> get props => [email];

  @override
  bool get stringify => true;
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  SignUpPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];

  @override
  bool get stringify => true;
}

class SignUpButtonPressed extends SignUpEvent {
  final String email;
  final String password;
  final String confirmPassword;

  SignUpButtonPressed({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [email, password, confirmPassword];

  @override
  bool get stringify => true;
}

class ConfirmPasswordChanged extends SignUpEvent {
  final String password;
  final String confirmPassword;

  ConfirmPasswordChanged(this.password, this.confirmPassword);

  @override
  List<Object?> get props => [password];

  @override
  bool get stringify => true;
}

class Submitted extends SignUpEvent {
  final String email;
  final String password;
  final String confirmPassword;

  Submitted({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [email, password];

  @override
  bool get stringify => true;
}
