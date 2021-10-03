import 'package:equatable/equatable.dart';

class AuthException implements Exception {}

class CacheException implements Exception {}

class DatabaseException implements Exception {}

class InValidKeywordException implements Exception {}

class ServerException implements Exception {}

class InvalidCredentials extends Equatable implements Exception {
  late final String message;

  InvalidCredentials({
    this.message = "The email or password entered is incorrect.",
  });

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;
}
