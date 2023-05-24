part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  const SignInState({
    // TODO: убрать данные
    this.email = "",
    this.emailValidated = false,
    this.password = "",
    this.submissionStatus = SubmissionStatus.idle,
  });

  final String email;
  final bool emailValidated;
  final String password;
  final SubmissionStatus submissionStatus;

  SignInState copyWith({
    String? email,
    String? password,
    bool? emailValidated,
    SubmissionStatus? submissionStatus,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailValidated: emailValidated ?? this.emailValidated,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [email, emailValidated, password, submissionStatus];
}

class SignInInitial extends SignInState {}

enum SubmissionStatus {
  idle,
  inProgress,
  success,
  invalidCredentialError,
  genericError,
}