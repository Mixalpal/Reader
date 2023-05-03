import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:developer';

import '../data/account.dart';

class AccountRepository {
  final FirebaseFirestore db;
  List<Account> _accounts = [];
  Account? currentAccount = null;

  AccountRepository({
    required this.db,
  });

  Future<List<Account>> getAll() async {
    List<Account> result = [];
    QuerySnapshot snap = await db.collection("account").get();
    final snapData = snap.docs.map((doc) => doc.data()).toList();
    snapData.forEach((element) {
      print("element: $element");
      result.add(Account.fromMap(element as Map<String, dynamic>));
    });
    _accounts = result;
    return result;
  }

  void update(Account account) {}

  void register(String emailAddress, String login, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          )
          .then((data) => {createAccount(data.user?.uid, login)});
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void createAccount(String? uid, String login) async {
    try {
      if (uid == null) {
        log("uid is null on creating account during user registration");
        return;
      }
      if (_accounts.isEmpty) {
        await getAll();
      }
      for (int i = 0; i < _accounts.length; i++) {
        if (_accounts[i].username == login) {
          throw Error();
        }
      }

      Account account = Account(
          booksIdList: [],
          imgLink: "",
          role: "reader",
          xp: 0,
          reviewsIdList: [],
          achievementsIdList: [],
          userId: uid,
          username: login);
      db.collection("account").doc(uid).set(account.toMap());
    } catch (e) {
      log(e.toString());
      log("Ошибка при создании аккаунта");
    }
  }

  Future<Account> authenticate(String email, String password) async {
    Account result;
    String uid = "";
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((userCredential) => {uid = userCredential.user!.uid});
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
    result =
        Account.fromJson(db.collection('account').doc(uid).get().toString());
    return result;
  }
}
