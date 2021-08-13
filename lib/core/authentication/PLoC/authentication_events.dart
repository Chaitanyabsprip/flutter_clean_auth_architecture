import 'package:equatable/equatable.dart';

class AppStarted extends AuthenticationEvent {}

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => const [];
}

class LoggedIn extends AuthenticationEvent {}

class LoggedOut extends AuthenticationEvent {}
