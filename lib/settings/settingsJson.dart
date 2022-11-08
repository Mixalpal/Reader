import 'package:json_annotation/json_annotation.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
part 'settingsJson.g.dart';

@JsonSerializable()
class SettingsJson {
  late String font;
  late int fontSize;
  late String sortingPrinciple;
  late bool isChecked;

  //SettingsJson(this.font, this.fontSize, this.sortingPrinciple, this.isChecked);
  SettingsJson(
      this.font, this.fontSize, this.sortingPrinciple, this.isChecked) {
    create();
  }

  void create() async {
    String path = await _localPath;
    if (await File('$path/settings.json').exists() == false) {
      final String response =
          await rootBundle.loadString('assets/settings.json');
      final data = await json.decode(response);
      isChecked = data["isChecked"];
      font = data["font"];
      fontSize = data["fontSize"];
      sortingPrinciple = data["sortingPrinciple"];
    } else {
      final file = await _localFile;
      final contents = await file.readAsString();
      if (contents != "") {
        Map<String, dynamic> jsonMap = jsonDecode(contents);
        SettingsJson json = SettingsJson.fromJson(jsonMap);
        font = json.font;
        fontSize = json.fontSize;
        isChecked = json.isChecked;
        sortingPrinciple = json.sortingPrinciple;
      } else {
        final String response =
            await rootBundle.loadString('assets/settings.json');
        final data = await json.decode(response);
        isChecked = data["isChecked"];
        font = data["font"];
        fontSize = data["fontSize"];
        sortingPrinciple = data["sortingPrinciple"];
      }
    }
  }

  factory SettingsJson.fromJson(Map<String, dynamic> json) =>
      _$SettingsJsonFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsJsonToJson(this);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/settings.json');
  }

  Future<File> writeJson() async {
    final file = await _localFile;

    return file.writeAsString(jsonEncode(this));
  }

  // factory SettingsJson.fromJson(dynamic json) {
  // return SettingsJson(json['font'] as String, json['fontSize'] as int, json['sortingPrinciple'] as String, json['isChecked'] as bool);
}
