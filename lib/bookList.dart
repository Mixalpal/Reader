import 'package:flutter/material.dart';
import 'bookWidget.dart';

class BookList extends StatefulWidget {
  const BookList({super.key});

  final String _bookPath = "";

  @override
  State<BookList> createState() => _BookList();
}

class _BookList extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: <BookWidget>[
        BookWidget(),
        BookWidget(),
        BookWidget(),
        BookWidget(),
        BookWidget(),
      ],
    );
  }
}
