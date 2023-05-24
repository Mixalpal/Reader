import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_application_1/data/library_book.dart';

class LibraryBookRepository {
  LibraryBookRepository() {
    db = FirebaseFirestore.instance;
  }

  late FirebaseFirestore db;
  List<LibraryBook> libraryBookList = [];

  Future<LibraryBook> getLibraryBook(String uid) async {
    DocumentSnapshot _snap = await db.collection('book').doc(uid).get();
    return LibraryBook.fromMap(_snap.data() as Map<String, dynamic>, uid);
  }

  Future<List<LibraryBook>> getUserLibraryBooks(List<String> ids) async {
    List<LibraryBook> result = [];
    ids.forEach((element) async {
      result.add(await getLibraryBook(element));
    });
    libraryBookList = result;
    log('libraryBookList: $libraryBookList');
    return result;
  }

  String createBook(LibraryBook libraryBook) {
    DocumentReference docReference = db.collection('book').doc();
    docReference.set(libraryBook.toMap()).then((doc) {
      log('Created a book with id: ${docReference.id}');
    });
    return docReference.id;
  }
}
