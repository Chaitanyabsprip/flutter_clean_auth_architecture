import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInEmailChanged extends SignInEvent {
  final String email;

  SignInEmailChanged(this.email);

  @override
  List<Object?> get props => [email];

  @override
  bool get stringify => true;
}

class SignInPasswordChanged extends SignInEvent {
  final String password;

  SignInPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];

  @override
  bool get stringify => true;
}

class SignInWithCredentialsPressed extends SignInEvent {
  final String email;
  final String password;

  SignInWithCredentialsPressed({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];

  @override
  bool get stringify => true;
}

class ForgotPasswordButtonPressed extends SignInEvent {
  final String email;

  ForgotPasswordButtonPressed({required this.email});

  @override
  List<Object?> get props => [email];

  @override
  bool get stringify => true;
}

class SignInWithGooglePressed extends SignInEvent {}

class Submitted extends SignInEvent {
  final String email;
  final String password;

  Submitted({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];

  @override
  bool get stringify => true;
}
