import 'package:equatable/equatable.dart';

import '../../domain/entity/user.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState {
  final User user;
  Authenticated({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthenticationError extends AuthenticationState {
  final String message;

  AuthenticationError({required this.message});

  @override
  List<Object> get props => [message];
}

class UnAuthenticated extends AuthenticationState {}

class UnInitialized extends AuthenticationState {}
