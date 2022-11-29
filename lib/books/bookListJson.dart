import 'package:flutter_application_1/books/book.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
part 'bookListJson.g.dart';

@JsonSerializable()
class BookListJson {
  late List<Book> bookList = [];

  BookListJson({required this.bookList}) {
    create();
  }

  List<Book> getBookList() {
    return bookList;
  }

  void addBook(Book book) {
    bookList.add(book);
    writeJson();
  }

  void create() async {
    String path = await _localPath;
    if (await File('$path/bookList.json').exists() == false) {
      return;
    } else {
      final file = await _localFile;
      final contents = await file.readAsString();
      if (contents != "") {
        Map<String, dynamic> jsonMap = jsonDecode(contents);
        BookListJson json = BookListJson.fromJson(jsonMap);
        bookList = json.bookList;
      }
    }
  }

  factory BookListJson.fromJson(Map<String, dynamic> json) =>
      _$BookListJsonFromJson(json);
  Map<String, dynamic> toJson() => _$BookListJsonToJson(this);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/bookList.json');
  }

  Future<File> writeJson() async {
    final file = await _localFile;
    return file.writeAsString(jsonEncode(this));
  }
}
