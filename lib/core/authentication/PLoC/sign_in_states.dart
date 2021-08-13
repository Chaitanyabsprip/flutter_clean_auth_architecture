import 'package:equatable/equatable.dart';

class SignInState extends Equatable {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  SignInState({
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  factory SignInState.empty() {
    return SignInState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory SignInState.loading() {
    return SignInState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory SignInState.failure() {
    return SignInState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory SignInState.success() {
    return SignInState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  SignInState update({
    bool isEmailValid = false,
    bool isPasswordValid = false,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  SignInState copyWith({
    bool isEmailValid = false,
    bool isPasswordValid = false,
    bool isSubmitEnabled = false,
    bool isSubmitting = false,
    bool isSuccess = false,
    bool isFailure = false,
  }) {
    return SignInState(
      isEmailValid: isEmailValid || this.isEmailValid,
      isPasswordValid: isPasswordValid || this.isPasswordValid,
      isSubmitting: isSubmitting || this.isSubmitting,
      isSuccess: isSuccess || this.isSuccess,
      isFailure: isFailure || this.isFailure,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props =>
      [isEmailValid, isPasswordValid, isSubmitting, isSuccess, isFailure];
}
