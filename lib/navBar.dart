import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/bookList.dart';
import 'package:flutter_application_1/settings/settings.dart';
import 'package:flutter_application_1/settings/settingsJson.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_application_1/books/bookListJson.dart';
import 'package:flutter_application_1/books/book.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  int _selectedIndex = 0;
  final BookListJson _bookListJson = BookListJson(bookList: []);
  List<Book> _bookList = [];

  static const imgSrc = "https://picsum.photos/250?image=9";

  static const TextStyle optionStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget getBody() {
    switch (_selectedIndex) {
      case 0:
        return Stack(children: [
          BookList(bookList: _bookListJson.getBookList()),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles();
                  if (result == null) return;
                  final file = result.files.first;
                  Book newBook = Book(
                      name: file.name,
                      author: "автор книги",
                      coverSrc: imgSrc,
                      path: file.path);
                  setState(() {
                    _bookListJson.addBook(newBook);
                    _bookListJson.writeJson();
                    _bookList = _bookListJson.getBookList();
                  });
                },
                backgroundColor: const Color.fromRGBO(236, 143, 0, 1),
                child: Icon(Icons.add, size: 30),
              ),
            ),
          )
        ]);
      case 1:
        return BookList(
          bookList: _bookListJson.getBookList(),
        );
      case 2:
        return Settings();
      default:
        return Text("Что-то пошло не так");
    }
  }

  @override
  void initState() {
    // Future.delayed(Duration.zero, () async {
    //   Permission.manageExternalStorage.request();
    //   var status = await Permission.manageExternalStorage.status;
    //   if (status.isDenied) {
    //     await Permission.manageExternalStorage.request();
    //   }
    //   if (await Permission.manageExternalStorage.isRestricted) {}
    // });
    Future.delayed(Duration.zero, () async {
      _bookList = _bookListJson.getBookList();
    });
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Здесь будет поиск'),
        backgroundColor: const Color.fromRGBO(236, 143, 0, 1),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 9125,
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                    width: MediaQuery.of(context).size.width,
                    child: getBody(),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 875,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    color: (_selectedIndex == 0)
                        ? const Color.fromRGBO(255, 185, 78, 1)
                        : const Color.fromRGBO(236, 143, 0, 1),
                    child: GestureDetector(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ImageIcon(
                                AssetImage('assets/images/BookVector.png')),
                            Text(
                              "Книги",
                              textAlign: TextAlign.center,
                              style: optionStyle,
                            ),
                          ],
                        ),
                      ),
                      onTap: () => {_onItemTapped(0)},
                    ),
                  ),
                  Container(
                    color: (_selectedIndex == 1)
                        ? const Color.fromRGBO(255, 185, 78, 1)
                        : const Color.fromRGBO(236, 143, 0, 1),
                    child: GestureDetector(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Column(
                          children: <Widget>[
                            ImageIcon(
                                AssetImage('assets/images/StarVector.png')),
                            Text(
                              "Избранное",
                              textAlign: TextAlign.center,
                              style: optionStyle,
                            ),
                          ],
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ),
                      onTap: () => {_onItemTapped(1)},
                    ),
                  ),
                  Container(
                    color: (_selectedIndex == 2)
                        ? const Color.fromRGBO(255, 185, 78, 1)
                        : const Color.fromRGBO(236, 143, 0, 1),
                    child: GestureDetector(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Column(
                          children: <Widget>[
                            ImageIcon(
                              AssetImage('assets/images/SettingsVector.png'),
                            ),
                            Text(
                              "Настройки",
                              textAlign: TextAlign.center,
                              style: optionStyle,
                            ),
                          ],
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ),
                      onTap: () => {_onItemTapped(2)},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
