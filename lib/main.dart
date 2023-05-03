import 'package:flutter/material.dart';
import 'navBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import './test/testWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  //Bloc.observer = AppBlocObserver();
  //await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(255, 185, 78, 1),
        unselectedWidgetColor: Color.fromRGBO(204, 204, 204, 1),
      ),
      home: TestWidget(),
    );
  }
}
