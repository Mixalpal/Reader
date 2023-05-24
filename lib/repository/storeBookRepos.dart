import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';
import '../data/store_book.dart';

class StoreBookRepository {
  late FirebaseFirestore db;

  List<StoreBook> storeBookList = [];

  StoreBookRepository() {
    db = FirebaseFirestore.instance;
    getAll();
    print('storeBooksList: $storeBookList');
  }

  Future<List<StoreBook>> getAll() async {
    if (storeBookList.isNotEmpty) {
      return storeBookList;
    }
    List<StoreBook> result = [];
    var querySnapshot = await db.collection("storeBook").get();
    querySnapshot.docs.forEach((doc) {
      result.add(StoreBook.fromMap(doc.data(), doc.id, false));
    });
    storeBookList = result;
    print(storeBookList[0].author);
    return result;
  }

  Future<StoreBook> getStoreBook(String uid) async {
    DocumentSnapshot _snap = await db.collection('storeBook').doc(uid).get();
    return StoreBook.fromMap(_snap.data() as Map<String, dynamic>, uid, false);
  }

  void update(StoreBook storeBook) {
    db.collection('storeBook').doc(storeBook.id).set(storeBook.toMap()).then(
        (value) => log("StoreBook updated Successfully!"),
        onError: (e) => log("Error updating StoreBook: $e"));
    return;
  }

  void getJUSTABOOKINTEXTPLS() async {
    var querySnapshot = await db.collection("review").get();
    querySnapshot.docs.forEach((doc) {
      print('VOT ONO ${doc.data()}');
    });
  }

  String createStoreBook(StoreBook storeBook) {
    DocumentReference docReference = db.collection('storeBook').doc();
    docReference.set(storeBook.toMap()).then((doc) {
      log('Created a book with id: ${docReference.id}');
    });
    return docReference.id;
  }
}
