import 'dart:convert';

import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String? id;
  final int score;
  final List<Comment> comments;
  final String text;
  final String authorId;
  final int likes;
  final String bookId;
  const Review({
    this.id,
    required this.score,
    required this.comments,
    required this.text,
    required this.authorId,
    required this.likes,
    required this.bookId,
  });

  Review copyWith({
    String? id,
    int? score,
    List<Comment>? comments,
    String? text,
    String? authorId,
    int? likes,
    String? bookId,
  }) {
    return Review(
      id: id ?? id,
      score: score ?? this.score,
      comments: comments ?? this.comments,
      text: text ?? this.text,
      authorId: authorId ?? this.authorId,
      likes: likes ?? this.likes,
      bookId: bookId ?? this.bookId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'score': score,
      'comments': comments.map((x) => x.toMap()).toList(),
      'text': text,
      'authorId': authorId,
      'likes': likes,
      'bookId': bookId,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map, String id) {
    return Review(
      id: id,
      score: map['score'].toInt() as int,
      comments: List<Comment>.from(
        (map['comments'] as List<dynamic>).map<Comment>(
          (x) => Comment.fromMap(x as Map<String, dynamic>),
        ),
      ),
      text: map['text'] as String,
      authorId: map['authorId'] as String,
      likes: map['likes'].toInt() as int,
      bookId: map['bookId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source, id) =>
      Review.fromMap(json.decode(source) as Map<String, dynamic>, id);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      score,
      comments,
      text,
      authorId,
      likes,
      bookId,
    ];
  }
}

class Comment extends Equatable {
  final String authorUsername;
  final String text;
  final String authorId;
  const Comment({
    required this.authorUsername,
    required this.text,
    required this.authorId,
  });

  Comment copyWith({
    String? authorUsername,
    String? text,
    String? authorId,
  }) {
    return Comment(
      authorUsername: authorUsername ?? this.authorUsername,
      text: text ?? this.text,
      authorId: authorId ?? this.authorId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'authorUsername': authorUsername,
      'text': text,
      'authorId': authorId,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      authorUsername: map['authorUsername'] as String,
      text: map['text'] as String,
      authorId: map['authorId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [authorUsername, text, authorId];
}
