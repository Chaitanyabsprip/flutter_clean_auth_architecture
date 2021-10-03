import '../../domain/entity/user.dart';
import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool confirmPasswordMatches;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  SignUpState({
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.confirmPasswordMatches,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  SignUpState update({
    bool isEmailValid = false,
    bool isPasswordValid = false,
    bool confirmPasswordMatches = false,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      confirmPasswordMatches: confirmPasswordMatches,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  SignUpState copyWith({
    bool isEmailValid = false,
    bool isPasswordValid = false,
    bool confirmPasswordMatches = false,
    bool isSubmitting = false,
    bool isSuccess = false,
    bool isFailure = false,
  }) {
    return SignUpState(
      isEmailValid: isEmailValid || this.isEmailValid,
      isPasswordValid: isPasswordValid || this.isPasswordValid,
      confirmPasswordMatches:
          confirmPasswordMatches || this.confirmPasswordMatches,
      isSubmitting: isSubmitting || this.isSubmitting,
      isSuccess: isSuccess || this.isSuccess,
      isFailure: isFailure || this.isFailure,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        isEmailValid,
        isPasswordValid,
        confirmPasswordMatches,
        isSubmitting,
        isSuccess,
        isFailure,
      ];
}

class SignUpError extends SignUpState {
  final String message;
  SignUpError({required this.message})
      : super(
          isEmailValid: true,
          isPasswordValid: true,
          confirmPasswordMatches: true,
          isSubmitting: false,
          isSuccess: false,
          isFailure: true,
        );

  @override
  List<Object?> get props => [message];
}

class SignUpFailure extends SignUpState {
  SignUpFailure()
      : super(
          isEmailValid: true,
          isPasswordValid: true,
          confirmPasswordMatches: true,
          isSubmitting: false,
          isSuccess: false,
          isFailure: true,
        );
}

class SignUpEmpty extends SignUpState {
  SignUpEmpty()
      : super(
          isEmailValid: true,
          isPasswordValid: true,
          confirmPasswordMatches: false,
          isSubmitting: false,
          isSuccess: false,
          isFailure: false,
        );
}

class SignUpLoading extends SignUpState {
  SignUpLoading()
      : super(
          isEmailValid: true,
          isPasswordValid: true,
          confirmPasswordMatches: true,
          isSubmitting: true,
          isSuccess: false,
          isFailure: false,
        );
}

class SignUpSuccess extends SignUpState {
  final User user;

  SignUpSuccess({required this.user})
      : super(
          isEmailValid: true,
          isPasswordValid: true,
          confirmPasswordMatches: true,
          isSubmitting: false,
          isSuccess: true,
          isFailure: false,
        );

  @override
  List<Object?> get props => [user];
}
