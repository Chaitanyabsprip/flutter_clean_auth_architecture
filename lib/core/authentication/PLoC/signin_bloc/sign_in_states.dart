import '../../domain/entity/user.dart';
import 'package:equatable/equatable.dart';

class SignInError extends SignInState {
  final String message;
  SignInError({required this.message})
      : super(
          isEmailValid: true,
          isPasswordValid: true,
          isSubmitting: false,
          isSuccess: false,
          isFailure: true,
        );

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => true;
}

class SignInFailure extends SignInState {
  final String message;
  SignInFailure({this.message = "Something went wrong"})
      : super(
          isEmailValid: true,
          isPasswordValid: true,
          isSubmitting: false,
          isSuccess: false,
          isFailure: true,
        );

  @override
  List<Object> get props => [message];

  @override
  bool? get stringify => true;
}

class SignInEmpty extends SignInState {
  SignInEmpty()
      : super(
          isEmailValid: true,
          isPasswordValid: true,
          isSubmitting: false,
          isSuccess: false,
          isFailure: false,
        );
}

class SignInLoading extends SignInState {
  SignInLoading()
      : super(
          isEmailValid: true,
          isPasswordValid: true,
          isSubmitting: true,
          isSuccess: false,
          isFailure: false,
        );
}

class SignInSuccess extends SignInState {
  final User user;

  SignInSuccess({required this.user})
      : super(
          isEmailValid: true,
          isPasswordValid: true,
          isSubmitting: false,
          isSuccess: true,
          isFailure: false,
        );

  @override
  List<Object?> get props => [user];
}

class SignInState extends Equatable {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  SignInState({
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  factory SignInState.from(SignInState state) {
    return state;
  }

  bool get isFormValid => isEmailValid && isPasswordValid;

  @override
  List<Object?> get props =>
      [isEmailValid, isPasswordValid, isSubmitting, isSuccess, isFailure];

  @override
  bool? get stringify => true;

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
}
