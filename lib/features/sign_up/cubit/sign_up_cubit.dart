import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/repository/accountRepos.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.accountRepository}) : super(SignUpInitial());

  final AccountRepository accountRepository;

  void onEmailChanged(String newEmail) {
    final newScreenState = state.copyWith(
      email: newEmail,
    );
    emit(newScreenState);
  }

  void onPasswordChanged(String newPassword) {
    final newScreenState = state.copyWith(
      password: newPassword,
    );
    emit(newScreenState);
  }

  void onUsernameChanged(String newUsername) {
    final newScreenState = state.copyWith(
      username: newUsername,
    );
    emit(newScreenState);
  }

  void onSubmit() async {
    var newState = state.copyWith(
      submissionStatus: SubmissionStatus.inProgress,
    );
    emit(newState);
    print(
        'registering email: ${state.email}, password: ${state.password}, username: ${state.username}');
    int code = await accountRepository.register(
        state.email, state.username, state.password);
    switch (code) {
      case 0:
        newState = state.copyWith(
          submissionStatus: SubmissionStatus.success,
        );
        emit(newState);
        log('emitting success state');
        break;
      case 1:
        newState = state.copyWith(
          submissionStatus: SubmissionStatus.invalidCredentialError,
        );
        emit(newState);
        break;
      default:
        newState = state.copyWith(
          submissionStatus: SubmissionStatus.genericError,
        );
        emit(newState);
    }
  }
}
