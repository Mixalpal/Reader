import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/books/book.dart';
import 'package:flutter_application_1/reader/reader_page.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/account.dart';
import '../repository/accountRepos.dart';

class TestWidget extends StatefulWidget {
  TestWidget({super.key});
  String textToShow = '1500000fyjyf';
  bool initialized = false;

  @override
  State<TestWidget> createState() => _TestWidget();
}

class _TestWidget extends State<TestWidget> {
  void subcribe() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  Future<void> register() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    var db = FirebaseFirestore.instance;
    AccountRepository repo = AccountRepository(db: db);
    return;
  }

  void getAccs() async {
    var db = FirebaseFirestore.instance;
    CollectionReference _colref =
        FirebaseFirestore.instance.collection("account");
    QuerySnapshot _snapshot = await _colref.get();
    final allData = _snapshot.docs.map((doc) => doc.data()).toList();

    print(allData);
  }

  void getAccsFromRepo() async {
    AccountRepository repo = AccountRepository(db: FirebaseFirestore.instance);
    List<Account> res = await repo.getAll();
    print("Accounts: $res");
    //print(res[0]);
  }

  void doThings() async {
    if (widget.initialized == false) {
      await Firebase.initializeApp(
          options: FirebaseOptions(
        apiKey: 'AIzaSyBZAxXAMQ02ag8kCJm8VY3yhwDlni8hThc',
        appId: '1:887081821853:web:90af35c2cfb1965f509674',
        messagingSenderId: '887081821853',
        projectId: 'dreamreader-aa940',
        authDomain: 'dreamreader-aa940.firebaseapp.com',
        storageBucket: 'dreamreader-aa940.appspot.com',
        measurementId: 'G-W7W5EZY3SM',
      ));
      subcribe();
    }
    widget.initialized = true;

    //register();
    //getAccs();
    getAccsFromRepo();

    setState(() {
      widget.textToShow = "pressed";
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [Container(height: 40)],
        ),
        Row(children: [Text(widget.textToShow)]),
        Row(
          children: [Container(height: 300)],
        ),
        Row(children: [
          GestureDetector(
              child: Container(
                color: Colors.blue,
                height: 200,
                width: 200,
              ),
              onTap: () => doThings())
        ])
      ],
    );
  }
}
