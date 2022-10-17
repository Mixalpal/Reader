import 'dart:ui';

import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Здесь будут книги',
      style: optionStyle,
    ),
    Text(
      'Здесь будет избранное',
      style: optionStyle,
    ),
    Text(
      'Здесь будут настройки',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [Text("Центр")],
              ),
            ),
            Expanded(
              flex: 875,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    //width: MediaQuery.of(context).size.width / 3,
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
