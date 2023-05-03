import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fb2_parse/fb2_parse.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter/src/webview_controller.dart';
import 'package:webview_flutter/src/webview_widget.dart';

class Reader {
  late double progress;
  String badpath =
      "C:\\Users\\Mikhail\\Downloads\\Sorokin_Istoriya-budushchego-Sorokin-_3_Metel.-ErqoA.617711.fb2";
  late String bookcontent = "Examplerino";
  late String filename;
  late int start = 0;
  late int end = 100;

  late FB2Book fb2book;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localFile;

    return File("$path/$filename");
  }

  Reader(String filename) {
    progress = 0; // get Progress from saved json or db
    filename = filename;
    readfile();
    print(bookcontent);
  }

  void readfile() async {
    File file = await _localFile;
    final path = await _localPath;
    print("$path/$filename");
    fb2book = FB2Book("$path/$filename");
    await fb2book.parse();

    Stream<String> lines =
        file.openRead().transform(utf8.decoder).transform(LineSplitter());
    bookcontent = await lines.first;
    print(lines.first);
    print(fb2book.body.sections![0]);
  }

  late String pagetext;

  String getNextPage() {
    String nextPage = "";
    nextPage = bookcontent.substring(start, end);
    start += 100;
    end += 100;
    return nextPage;
  }

  String getPrevPage() {
    String prevpage = "";
    prevpage = bookcontent.substring(start, end);
    start -= 100;
    end -= 100;
    return prevpage;
  }

  // bool hasTextOverflow(String text, TextStyle style,
  //     {double minWidth = 0,
  //     double maxWidth = MediaQuery.of(context).size.width - 80,
  //     int maxLines = 2}) {
  //   final TextPainter textPainter = TextPainter(
  //     text: TextSpan(text: text, style: style),
  //     maxLines: maxLines,
  //     textDirection: TextDirection.ltr,
  //   )..layout(minWidth: minWidth, maxWidth: maxWidth);
  //   return textPainter.didExceedMaxLines;
  // }
}
