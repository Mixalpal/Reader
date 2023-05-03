// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      name: json['name'] as String,
      author: json['author'] as String,
      coverSrc: json['coverSrc'] as String,
      path: json['path'] as String,
    )
      ..progress = (json['progress'] as num).toDouble()
      ..isFavourite = json['isFavourite'] as bool;

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'name': instance.name,
      'author': instance.author,
      'progress': instance.progress,
      'coverSrc': instance.coverSrc,
      'path': instance.path,
      'isFavourite': instance.isFavourite,
    };
