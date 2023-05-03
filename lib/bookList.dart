import 'package:flutter/material.dart';
import 'bookWidget.dart';
import 'package:flutter_application_1/books/book.dart';

class BookList extends StatefulWidget {
  final List<Book> bookList;
  const BookList({super.key, required this.bookList});

  @override
  State<BookList> createState() => _BookList();
}

class _BookList extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView(
        scrollDirection: Axis.vertical,
        children: [for (var book in widget.bookList) BookWidget(book: book)],
      ),
    ]);
  }
}
