import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/reader/readingAppBar.dart';
import 'package:flutter_application_1/books/book.dart';
import 'package:flutter_application_1/reader/reader.dart';
import 'package:flutter_application_1/reader/reader_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Reader_Page extends StatelessWidget {
  const Reader_Page({super.key, required this.filePath});
  final String filePath;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReaderBloc(filePath: filePath),
      child: const ReaderView(),
    );
  }
}

class ReaderView extends StatelessWidget {
  const ReaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //AppBar
        Row(),
        //Text
        Container(
            //Text
            padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
            child: Text(
              context.select((ReaderBloc bloc) => bloc.state.text),
              maxLines: 30,
              softWrap: true,
            )),
        //GestureDetectors
        Row(
          children: [
            Column(),
            Column(),
            Column(),
          ],
        ),
      ],
    );
  }
}
