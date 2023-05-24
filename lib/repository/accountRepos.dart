import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import '../data/account.dart';

class AccountRepository {
  late FirebaseFirestore db;
  List<Account> _accounts = [];
  Account? currentAccount = null;

  AccountRepository() {
    db = FirebaseFirestore.instance;
    subscribe();
  }

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

  void update(Account account) {
    db.collection('account').doc(account.userId).set(account.toMap()).then(
        (value) => log("Account updated Successfully!"),
        onError: (e) => log("Error updating account: $e"));
  }

  Future<Account> getAccount(String uid) async {
    DocumentSnapshot _snap = await db.collection('account').doc(uid).get();
    return Account.fromMap(_snap.data() as Map<String, dynamic>);
  }

  Future<int> register(
      String emailAddress, String login, String password) async {
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
        return 1;
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        return 2;
      }
    } catch (e) {
      log(e.toString());
    }
    return 0;
  }

  Future<int> createAccount(String? uid, String login) async {
    try {
      if (uid == null) {
        log("uid is null on creating account during user registration");
        return 1;
      }
      // if (_accounts.isEmpty) {
      //   await getAll();
      // }
      // for (int i = 0; i < _accounts.length; i++) {
      //   if (_accounts[i].username == login) {
      //     throw Error();
      //   }
      // }

      Account account = Account(
          booksIdList: [],
          storeBooksIdList: [],
          imgLink: "",
          role: "reader",
          xp: 0,
          reviewsIdList: [],
          achievementsIdList: [],
          userId: uid,
          username: login);
      await db.collection("account").doc(uid).set(account.toMap());
      currentAccount = account;
    } catch (e) {
      log(e.toString());
      log("Ошибка при создании аккаунта");
      return 2;
    }
    return 0;
  }

  Future<int> authenticate(String email, String password) async {
    Account result;
    String uid = "";
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((userCredential) => {getAccount(userCredential.user!.uid)});
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
      return 1;
    }
    return 0;
  }

  void subscribe() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        log('User is currently signed out!');
      } else {
        //currentAccount = await getAccount(user.uid);
        log('User is signed in. His account is: $currentAccount');
      }
    });
    FirebaseAuth.instance.userChanges().listen((User? user) async {
      if (user == null) {
        log('User is currently signed out!');
      } else {
        //currentAccount = await getAccount(user.uid);
        log('User is signed in. His account is: $currentAccount');
      }
    });
  }

  Future<Account> getCurrentAccount() async {
    if (currentAccount != null) {
      return currentAccount!;
    } else {
      currentAccount = await getAccount(FirebaseAuth.instance.currentUser!.uid);
      return await getAccount(FirebaseAuth.instance.currentUser!.uid);
    }
  }

  void buyABook(String bookId, storeBookId) async {
    await getCurrentAccount();
    currentAccount?.booksIdList.add(bookId);
    currentAccount?.storeBooksIdList.add(storeBookId);
    update(currentAccount!);
  }
}
