import '../../domain/entity/user.dart';
import 'package:equatable/equatable.dart';

class AppStarted extends AuthenticationEvent {}

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => const [];
}

class LoggedIn extends AuthenticationEvent {
  final User user;

  LoggedIn({required this.user});

  @override
  List<Object?> get props => [user];
}

class LoggedOut extends AuthenticationEvent {}
