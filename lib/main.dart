import 'package:flutter/material.dart';
import 'navBar.dart';
import 'bookList.dart';
import 'bookWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          //primaryColor: const Color.fromRGBO(255, 185, 78, 1),
          ),
      home: const NavBar(),
    );
  }
}
