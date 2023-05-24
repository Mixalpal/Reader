part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.email = "",
    this.password = "",
    this.username = "",
    this.submissionStatus = SubmissionStatus.idle,
  });

  final String email;
  final String password;
  final String username;
  final SubmissionStatus submissionStatus;

  SignUpState copyWith({
    String? email,
    String? username,
    String? password,
    SubmissionStatus? submissionStatus,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        username,
        submissionStatus,
      ];
}

class SignUpInitial extends SignUpState {}

enum SubmissionStatus {
  idle,
  inProgress,
  success,
  invalidCredentialError,
  genericError,
}
