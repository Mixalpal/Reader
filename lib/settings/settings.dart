import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/settings/settingsJson.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/firebase_options.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {
  SettingsJson _settingsJson =
      SettingsJson("Загружаем данные", 65535, "Загружаем данные", false);

  final TextStyle mainTextStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  final TextStyle secondaryTextStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 16,
    fontWeight: FontWeight.w300,
  );
  final List<String> _fonts = [
    'Bodoni',
    'PT Sans',
    'Tahoma',
    'PT Serif',
    'Arial Rounded MT Bold'
  ];
  final List<String> _sortingPrinciples = [
    'По дате посл. открытия (убыв.)',
    'По дате посл. открытия (возр.)',
    'По названию',
    'По автору',
  ];

  Future<void> readAssetJson() async {
    final String response = await rootBundle.loadString('assets/settings.json');
    final data = await json.decode(response);
    setState(() {
      _settingsJson.isChecked = data["isChecked"];
      _settingsJson.font = data["font"];
      _settingsJson.fontSize = data["fontSize"];
      _settingsJson.sortingPrinciple = data["sortingPrinciple"];
    });
    _settingsJson.writeJson();
  }

  Future<void> readDBJson() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection("defaultSettings").get().then((event) {
      for (var doc in event.docs) {
        setState(() {
          _settingsJson = SettingsJson.fromJson(doc.data());
        });
      }
    });
  }

  Future<void> readFileSystemJson() async {
    await readDBJson();
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/settings.json');
    if (await file.exists()) {
      final content = await file.readAsString();
      // setState(() {
      //   _settingsJson = SettingsJson.fromJson(jsonDecode(content));
      // });
      return;
    }
    readAssetJson();
    return;
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      readFileSystemJson();
    });
    super.initState();
  }

  void _showSimpleDialog(int type) {
    showDialog(
        context: context,
        builder: (context) {
          switch (type) {
            case 0:
              return SimpleDialog(
                title: Text('Выберите шрифт'),
                children: <Widget>[
                  for (String font in _fonts)
                    SimpleDialogOption(
                      onPressed: () {
                        setState(() {
                          _settingsJson.font = font;
                          _settingsJson.writeJson();
                        });
                        Navigator.pop(context);
                      },
                      child: Text(font),
                    ),
                ],
              );
            case 1:
              return SimpleDialog(
                title: Text('Выберите способ сортировки библиотеки'),
                children: <Widget>[
                  for (String principle in _sortingPrinciples)
                    SimpleDialogOption(
                      onPressed: () {
                        setState(() {
                          _settingsJson.sortingPrinciple = principle;
                          _settingsJson.writeJson();
                        });
                        Navigator.pop(context);
                      },
                      child: Text(principle, style: secondaryTextStyle),
                    ),
                ],
              );
            default:
              return Text("Произошла ошибка. Перезапустите приложение");
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(scrollDirection: Axis.vertical, children: <Widget>[
      GestureDetector(
        onTap: () => {_showSimpleDialog(0)},
        child: Container(
          height: 60,
          margin: const EdgeInsets.fromLTRB(0, 7, 0, 0),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Color.fromRGBO(204, 204, 204, 1),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(9, 8, 0, 0),
                      child: Text(
                        "Шрифт",
                        style: mainTextStyle,
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(9, 0, 0, 0),
                      child: Text(
                        _settingsJson.font,
                        style: secondaryTextStyle,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
      Container(
        height: 60,
        margin: const EdgeInsets.fromLTRB(0, 7, 0, 0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Color.fromRGBO(204, 204, 204, 1),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(9, 8, 0, 0),
                    child: Text(
                      "Размер шрифта по умолчанию",
                      style: mainTextStyle,
                    ),
                  ),
                )),
            Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(9, 0, 0, 0),
                    child: Text(
                      _settingsJson.fontSize.toString(),
                      style: secondaryTextStyle,
                    ),
                  ),
                )),
          ],
        ),
      ),
      Container(
        height: 60,
        margin: const EdgeInsets.fromLTRB(0, 7, 0, 0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Color.fromRGBO(204, 204, 204, 1),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
                flex: 305,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(9, 0, 0, 0),
                    child: Text(
                      "Показывать статистику после чтения",
                      maxLines: 2,
                      style: mainTextStyle,
                    ),
                  ),
                )),
            Expanded(
                flex: 37,
                child: Align(
                  alignment: Alignment.center,
                  child: Checkbox(
                      checkColor: Color.fromRGBO(255, 255, 255, 1),
                      activeColor: Color.fromRGBO(236, 143, 0, 1),
                      value: _settingsJson.isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _settingsJson.isChecked = value!;
                          _settingsJson.writeJson();
                        });
                      }),
                )),
          ],
        ),
      ),
      GestureDetector(
        onTap: () => {_showSimpleDialog(1)},
        child: Container(
          height: 60,
          margin: const EdgeInsets.fromLTRB(0, 7, 0, 0),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Color.fromRGBO(204, 204, 204, 1),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(9, 8, 0, 0),
                      child: Text(
                        "Сортировка библиотеки",
                        style: mainTextStyle,
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(9, 0, 0, 0),
                      child: Text(
                        _settingsJson.sortingPrinciple,
                        style: secondaryTextStyle,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    ]);
  }
}
