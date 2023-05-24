import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/repository/accountRepos.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({required this.accountRepository}) : super(const SignInState());

  final AccountRepository accountRepository;

  void onEmailChanged(String newEmail) {
    final newScreenState = state.copyWith(
      email: newEmail,
      emailValidated: false,
    );
    emit(newScreenState);
  }

  void onPasswordChanged(String newPassword) {
    final newScreenState = state.copyWith(
      password: newPassword,
    );
    emit(newScreenState);
  }

  void onSubmit() async {
    if (state.emailValidated == false) {
      var newState = state.copyWith(
        submissionStatus: SubmissionStatus.inProgress,
      );
      emit(newState);
      if (await accountRepository.authenticate(state.email, state.password) ==
          0) {
        newState = state.copyWith(
          submissionStatus: SubmissionStatus.success,
        );
        emit(newState);
      } else {
        newState = state.copyWith(
          submissionStatus: SubmissionStatus.genericError,
        );
        emit(newState);
      }
    }
  }

  void checkAuthentication() {
    if (accountRepository.currentAccount == null) {
      return;
    }
    print('Current Account: ${accountRepository.currentAccount}');
    final newScreenState = state.copyWith(
      submissionStatus: SubmissionStatus.success,
    );
    emit(newScreenState);
  }

  // bool _validateEmail(String email) {
  //   return _emailRegex.hasMatch(email) ? true : false;
  // }

  // static final _emailRegex = RegExp(
  //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  // static final _emailRegex = RegExp(
  //   '^(([\\w-]+\\.)+[\\w-]+|([a-zA-Z]|[\\w-]{2,}))@((([0-1]?'
  //   '[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.'
  //   '([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])'
  //   ')|([a-zA-Z]+[\\w-]+\\.)+[a-zA-Z]{2,4})\$',
  // );
}
