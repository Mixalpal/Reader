// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class StoreBook extends Equatable {
  final String? id;
  final bool? bought;
  final String annotation;
  final String author;
  final num avgScore;
  final String fileLink;
  final String? imgLink;
  final String name;
  final num price;
  final List<String> reviewsIdList;
  final List<String> tagIdList;
  const StoreBook({
    this.id,
    this.bought,
    required this.annotation,
    required this.author,
    required this.avgScore,
    required this.fileLink,
    this.imgLink,
    required this.name,
    required this.price,
    required this.reviewsIdList,
    required this.tagIdList,
  });

  StoreBook copyWith({
    String? id,
    bool? bought,
    String? annotation,
    String? author,
    double? avgScore,
    String? fileLink,
    String? imgLink,
    String? name,
    double? price,
    List<String>? reviewsIdList,
    List<String>? tagIdList,
  }) {
    return StoreBook(
      id: id ?? this.id,
      bought: bought ?? this.bought,
      annotation: annotation ?? this.annotation,
      author: author ?? this.author,
      avgScore: avgScore ?? this.avgScore,
      fileLink: fileLink ?? this.fileLink,
      imgLink: imgLink ?? this.imgLink,
      name: name ?? this.name,
      price: price ?? this.price,
      reviewsIdList: reviewsIdList ?? this.reviewsIdList,
      tagIdList: tagIdList ?? this.tagIdList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'annotation': annotation,
      'author': author,
      'avgScore': avgScore,
      'fileLink': fileLink,
      'imgLink': imgLink,
      'name': name,
      'price': price,
      'reviewsIdList': reviewsIdList,
      'tagIdList': tagIdList,
    };
  }

  factory StoreBook.fromMap(Map<String, dynamic> map, String uid, bool bought) {
    return StoreBook(
      id: uid,
      bought: bought,
      annotation: map['annotation'] as String,
      author: map['author'] as String,
      avgScore: map['avgScore'] as num,
      fileLink: map['fileLink'] as String,
      imgLink: map['imgLink'] != null ? map['imgLink'] as String : null,
      name: map['name'] as String,
      price: map['price'] as num,
      reviewsIdList: List<String>.from(map['reviewsIdList']),
      tagIdList: List<String>.from(map['tagList']),
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreBook.fromJson(String source, uid, bool bought) =>
      StoreBook.fromMap(
          json.decode(source) as Map<String, dynamic>, uid, bought);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      bought,
      annotation,
      author,
      avgScore,
      fileLink,
      imgLink,
      name,
      price,
      reviewsIdList,
      tagIdList,
    ];
  }
}
