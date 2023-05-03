import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/sign_in/cubit/sign_in_cubit.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);
  static Page page() => const MaterialPage<void>(child: SignInPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => SignInCubit(),
        child: const SignInForm(),
      )
    )
  }
}


