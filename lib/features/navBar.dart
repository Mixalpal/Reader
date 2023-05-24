import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/features/catalog/catalog_page.dart';
import 'package:flutter_application_1/features/library/library_page.dart';
import 'package:flutter_application_1/features/settings/settings.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  int _selectedIndex = 1;

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
        return LibraryPage();
      case 1:
        return CatalogPage();
      case 2:
        return Settings();
      default:
        return Text("Что-то пошло не так");
    }
  }

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DreamReader',
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
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
                              "Каталог",
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
