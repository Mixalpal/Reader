part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  const SignInState({
    this.email = "",
    this.emailValidated = false,
    this.password = "",
  });

  final String email;
  final bool emailValidated;
  final String password;

  SignInState copyWith({
    String? email,
    String? password,
    bool? emailValidated,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailValidated: emailValidated ?? this.emailValidated,
    );
  }

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}
