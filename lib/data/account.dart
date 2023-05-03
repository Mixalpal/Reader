// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final List<String> booksIdList;
  final String imgLink;
  final String role;
  final int xp;
  final List<String> reviewsIdList;
  final List<String> achievementsIdList;
  final String userId;
  final String username;

  const Account({
    required this.booksIdList,
    required this.imgLink,
    required this.role,
    required this.xp,
    required this.reviewsIdList,
    required this.achievementsIdList,
    required this.userId,
    required this.username,
  });

  Account copyWith({
    List<String>? booksIdList,
    String? imgLink,
    String? role,
    int? xp,
    List<String>? reviewsIdList,
    List<String>? achievementsIdList,
    String? userId,
    String? username,
  }) {
    return Account(
      booksIdList: booksIdList ?? this.booksIdList,
      imgLink: imgLink ?? this.imgLink,
      role: role ?? this.role,
      xp: xp ?? this.xp,
      reviewsIdList: reviewsIdList ?? this.reviewsIdList,
      achievementsIdList: achievementsIdList ?? this.achievementsIdList,
      userId: userId ?? this.userId,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'booksIdList': booksIdList,
      'imgLink': imgLink,
      'role': role,
      'xp': xp,
      'reviewsIdList': reviewsIdList,
      'achievementsIdList': achievementsIdList,
      'userId': userId,
      'username': username,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      booksIdList: List<String>.from(map['booksIdList']),
      imgLink: map['imgLink'] as String,
      role: map['role'] as String,
      xp: map['xp'] as int,
      reviewsIdList: List<String>.from(map['reviewsIdList']),
      achievementsIdList: List<String>.from(map['achievementsIdList']),
      userId: map['userId'] as String,
      username: map['username'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source) as Map<String, dynamic>);

  // factory Account.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  // ) {
  //   final data = snapshot.data();
  //   return Account(
  //     booksIdList: List.from(data?['booksIdList']),
  //     imgLink: data?['imgLink'],
  //     role: data?['role'],
  //     xp: data?['xp'],
  //     reviewsIdList: List.from(data?['reviewsIdList']),
  //     achievementsIdList: List.from(data?['achievementsIdList']),
  //     userId: data?['userId'],
  //     username: data?['username'],
  //   );
  // }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      booksIdList,
      imgLink,
      role,
      xp,
      reviewsIdList,
      achievementsIdList,
      userId,
      username,
    ];
  }
}
