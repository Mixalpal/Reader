import 'dart:convert';

import 'package:equatable/equatable.dart';

class LibraryBook extends Equatable {
  final String? id;
  final String storeBookId;
  final String fileLink;
  final String imgLink;
  final String author;
  final num progress;
  final String name;
  const LibraryBook({
    this.id,
    required this.storeBookId,
    required this.fileLink,
    required this.imgLink,
    required this.author,
    required this.progress,
    required this.name,
  });

  LibraryBook copyWith({
    String? id,
    String? annotation,
    String? fileLink,
    String? imgLink,
    String? author,
    int? progress,
    String? name,
  }) {
    return LibraryBook(
      id: id ?? this.id,
      storeBookId: annotation ?? this.storeBookId,
      fileLink: fileLink ?? this.fileLink,
      imgLink: imgLink ?? this.imgLink,
      author: author ?? this.author,
      progress: progress ?? this.progress,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'storeBookId': storeBookId,
      'fileLink': fileLink,
      'imgLink': imgLink,
      'author': author,
      'progress': progress,
      'name': name,
    };
  }

  factory LibraryBook.fromMap(Map<String, dynamic> map, String id) {
    return LibraryBook(
      id: id,
      storeBookId: map['storeBookId'] as String,
      fileLink: map['fileLink'] as String,
      imgLink: map['imgLink'] as String,
      author: map['author'] as String,
      progress: map['progress'] as num,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LibraryBook.fromJson(String source, id) =>
      LibraryBook.fromMap(json.decode(source) as Map<String, dynamic>, id);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      storeBookId,
      fileLink,
      imgLink,
      author,
      progress,
      name,
    ];
  }
}
