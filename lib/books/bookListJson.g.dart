// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookListJson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookListJson _$BookListJsonFromJson(Map<String, dynamic> json) => BookListJson(
      bookList: (json['bookList'] as List<dynamic>)
          .map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookListJsonToJson(BookListJson instance) =>
    <String, dynamic>{
      'bookList': instance.bookList,
    };
