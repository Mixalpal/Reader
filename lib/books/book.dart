import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
part 'book.g.dart';

@JsonSerializable()
class Book {
  late String name;
  late String author;
  late double progress;
  late String coverSrc;
  late String? path;
  late bool isFavourite;

  Book(
      {required this.name,
      required this.author,
      required this.coverSrc,
      required this.path}) {
    progress = 0;
    isFavourite = false;
  }
  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}
