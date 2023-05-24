import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:flutter_application_1/repository/accountRepos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static Page page() => const MaterialPage<void>(child: SignUpPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (_) => SignUpCubit(
        accountRepository: RepositoryProvider.of<AccountRepository>(context),
      ),
      child: const SignUpForm(),
    ));
  }
}

@visibleForTesting
class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
        listenWhen: (oldState, newState) =>
            oldState.submissionStatus != newState.submissionStatus,
        listener: (context, state) => {
              if (state.submissionStatus == SubmissionStatus.success)
                {context.go('/library')},
              if (state.submissionStatus == SubmissionStatus.genericError ||
                  state.submissionStatus ==
                      SubmissionStatus.invalidCredentialError)
                {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      state.submissionStatus ==
                              SubmissionStatus.invalidCredentialError
                          ? SnackBar(
                              content: Text(
                                'Неверно введены почта и/или пароль',
                              ),
                            )
                          : SnackBar(
                              content: Text(
                                'Аккаунт с этим адресом электронной почты уже существует',
                              ),
                            ),
                    )
                },
            },
        builder: (context, state) {
          //
          final isSubmissionInProgress =
              state.submissionStatus == SubmissionStatus.inProgress;
          final cubit = context.read<SignUpCubit>();
          return Align(
            alignment: Alignment.center,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color.fromRGBO(41, 41, 41, 1),
                      width: 3,
                    )),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        flex: 67,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'Регистрация',
                            textAlign: TextAlign.center,
                            style: mainTextStyle,
                          ),
                        )),
                    Expanded(
                        flex: 22,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: RichText(
                              text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Уже есть аккаунт? ',
                                style: secondaryTextStyle,
                              ),
                              TextSpan(
                                  text: 'Войти',
                                  style: linkTextStyle,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.go('/');
                                    })
                            ],
                          )),
                        )),
                    Expanded(
                      flex: 46,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: TextField(
                            onChanged: (String value) =>
                                cubit.onUsernameChanged(value),
                            textInputAction: TextInputAction.next,
                            autocorrect: false,
                            decoration: InputDecoration(
                              suffixIcon: const Icon(
                                Icons.login,
                              ),
                              enabled: !isSubmissionInProgress,
                              labelText: 'Логин',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 56,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: TextField(
                            onChanged: (String value) =>
                                cubit.onEmailChanged(value),
                            obscureText: false,
                            decoration: InputDecoration(
                              suffixIcon: const Icon(
                                Icons.alternate_email,
                              ),
                              enabled: !isSubmissionInProgress,
                              labelText: 'Эл. почта',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 56,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: TextField(
                            onChanged: (String value) =>
                                cubit.onPasswordChanged(value),
                            obscureText: true,
                            decoration: InputDecoration(
                              suffixIcon: const Icon(
                                Icons.password,
                              ),
                              enabled: !isSubmissionInProgress,
                              labelText: 'Пароль',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 68,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(236, 143, 0, 1),
                              ),
                              onPressed: () => {cubit.onSubmit()},
                              child: isSubmissionInProgress
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Войти',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ))),
                    ),
                    Expanded(flex: 10, child: Container()),
                  ],
                )),
          );
        });
  }
}

const TextStyle mainTextStyle = TextStyle(
  fontFamily: 'OpenSans',
  fontSize: 32,
  fontWeight: FontWeight.w700,
);
const TextStyle secondaryTextStyle = TextStyle(
  fontFamily: 'OpenSans',
  fontSize: 14,
  color: Colors.black,
  fontWeight: FontWeight.w400,
);
const TextStyle linkTextStyle = TextStyle(
  fontFamily: 'OpenSans',
  fontSize: 14,
  color: Colors.blue,
  decoration: TextDecoration.underline,
  fontWeight: FontWeight.w400,
);
