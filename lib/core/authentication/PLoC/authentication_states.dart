import 'package:equatable/equatable.dart';

import '../domain/entity/user.dart';

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

class UnAuthenticated extends AuthenticationState {}

class UnInitialized extends AuthenticationState {}
